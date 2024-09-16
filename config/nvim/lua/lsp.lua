local lsp = vim.lsp
local diagnostic = vim.diagnostic
local _border = "rounded"
local win_get_buf = vim.api.nvim_win_get_buf
local wo = vim.wo
local buf_line_count = vim.api.nvim_buf_line_count
local win_get_width = vim.api.nvim_win_get_width
local buf_get_lines = vim.api.nvim_buf_get_lines
local str_width = vim.fn.strwidth
local replace_termcodes = vim.api.nvim_replace_termcodes
local get_win_info = vim.fn.getwininfo
local win_is_valid = vim.api.nvim_win_is_valid
local keymap_del = vim.keymap.del
local feedkeys = vim.fn.feedkeys
local defer = vim.defer_fn
local buf_call = vim.api.nvim_buf_call
local nvim_cmd = vim.api.nvim_cmd
local exec_autocmds = vim.api.nvim_exec_autocmds
local win_close = vim.api.nvim_win_close
local o = vim.o
local keymap_set = vim.keymap.set

-- Turn off diagnostics altogether.
-- TODO: write a function to toggle this.
-- lsp.handlers["textDocument/publishDiagnostics"] = function() end

-- Make diagnostics much less noisy by default.
-- TODO: write a function to toggle (some of?) these settings.
diagnostic.config({ signs = true, underline = false, virtual_text = false })

-- Add borders to floating windows in the LSP.
-- Thanks to this post for the code: https://vi.stackexchange.com/a/39075.
lsp.handlers["textDocument/hover"] =
    lsp.with(lsp.handlers.hover, { border = _border })

lsp.handlers["textDocument/signatureHelp"] =
    lsp.with(lsp.handlers.signature_help, { border = _border })

diagnostic.config({ float = { border = _border } })

-- Wrap neovim's vim.lsp.handlers.hover. This allows us to change some of its
-- default settings and add keymaps that require information we can't easily get
-- at otherwise.
--
-- The code comes from noice.nvim, a user's dotfiles, and a GitHub issue—all
-- are linked below.
--
-- + https://github.com/folke/noice.nvim
-- + https://bit.ly/3ZkGCmD
-- + https://github.com/neovim/neovim/issues/27288

--- Return the height of the buffer in the window
---@param win_id integer
---@return integer
local win_buf_height = function(win_id)
    local buf = win_get_buf(win_id)

    -- If the buffer is not wrapped, the number of lines is straightforward.
    if not wo[win_id].wrap then
        return buf_line_count(buf)
    end

    local width = win_get_width(win_id)

    -- Compute the height of the buffer in the window.
    local lines = buf_get_lines(buf, 0, -1, false)
    local height = 0
    for _, line in ipairs(lines) do
        height = height + math.max(1, (math.ceil(str_width(line) / width)))
    end
    return height
end

local escape_keycodes = function(str)
    return replace_termcodes(str, true, true, true)
end

--- Scroll the window by delta lines
---@param win_id integer
---@param delta integer
local scroll = function(win_id, delta)
    if not win_is_valid(win_id) then
        keymap_del("n", "<C-f>", { buffer = true })
        keymap_del("n", "<C-b>", { buffer = true })
        if delta > 0 then
            feedkeys(escape_keycodes("<C-f>"))
        else
            feedkeys(escape_keycodes("<C-b>"))
        end
        return
    end

    local info = get_win_info(win_id)[1] or {}
    local top = info.topline or 1
    local buf = win_get_buf(win_id)
    top = top + delta
    top = math.max(top, 1)
    top = math.min(top, win_buf_height(win_id) - info.height + 1)

    defer(function()
        buf_call(buf, function()
            -- TODO: Investigate whether nvim_cmd > nvim_command here.
            -- nvim_cmd("noautocmd silent! normal! " .. top .. "zt")
            nvim_cmd({
                cmd = "normal",
                args = { top .. "zt" },
                bang = true,
                mods = { noautocmd = true, emsg_silent = true },
            }, {})
            exec_autocmds("WinScrolled", { modeline = false })
        end)
    end, 0)
end

---Close a floating window without entering it.
---@param win_id integer
local close_window = function(win_id)
    if not win_is_valid(win_id) then
        keymap_del("n", "<Leader>;", { buffer = true })
        feedkeys(escape_keycodes("<Leader>;"))
        return
    end
    win_close(win_id, false)
end

--- Wrap the default LSP floating window handlers in order to customize them.
---@param handler fun(err: any, res: any, ctx: any, cfg: any): integer?, integer?
---@param focusable boolean
---@return fun(err: any, result: any, ctx: any, cfg: any)
local float_handler = function(handler, focusable)
    return function(err, result, ctx, cfg)
        local buf_id, win_id = handler(
            err,
            result,
            ctx,
            vim.tbl_deep_extend("force", cfg or {}, {
                border = "rounded",
                focusable = focusable,
                max_height = math.floor(o.lines * 0.5),
                max_width = math.floor(o.columns * 0.4),
            })
        )

        -- Return if the buffer or window is not created.
        if not buf_id or not win_id then
            return
        end

        -- Set the window's scrolloffset to 0.
        wo[win_id].scrolloff = 0

        -- Turn off conceal.
        -- TODO: decide how I want to handle conceal here.
        wo[win_id].concealcursor = "n"
        -- wo[win_id].conceallevel = 0

        keymap_set("n", "<C-f>", function()
            scroll(win_id, 4)
        end, { silent = true, buffer = true })
        keymap_set("n", "<C-b>", function()
            scroll(win_id, -4)
        end, { silent = true, buffer = true })
        keymap_set("n", "<Leader>;", function()
            close_window(win_id)
        end, { silent = true, buffer = true })
    end
end

lsp.handlers["textDocument/hover"] = float_handler(lsp.handlers.hover, true)
lsp.handlers["textDocument/signatureHelp"] =
    float_handler(lsp.handlers.signature_help, false)
