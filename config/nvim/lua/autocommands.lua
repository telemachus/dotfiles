local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd
local o = vim.o
local bo = vim.bo
local cmd = vim.cmd
-- local lsp = vim.lsp
local keymap_set = vim.keymap.set
local defer_fn = vim.defer_fn
local on_yank = vim.hl.on_yank
local telemachus_augroup = create_augroup("TelemachusAugroup", { clear = true })

-- Highlight searches while searching, but not while moving over matches.
-- Taken from :help incsearch.  This should be the default.
create_autocmd("CmdlineEnter", {
    pattern = { "/", "?" },
    callback = function()
        o.hlsearch = true
    end,
    group = telemachus_augroup,
})
create_autocmd("CmdlineLeave", {
    pattern = { "/", "?" },
    callback = function()
        o.hlsearch = false
    end,
    group = telemachus_augroup,
})

-- Use only absolute line numbers when browsing help and man files.
create_autocmd("Filetype", {
    pattern = { "help", "man" },
    callback = function()
        o.number = false
        o.relativenumber = false
        o.statuscolumn = ""
        -- TODO: add a namespace for highlighting line numbers here.
    end,
    group = telemachus_augroup,
})

-- Highlight cursor line briefly when neovim regains focus.  This helps to
-- reorient the user and tell them where they are in the buffer.
-- See https://developer.ibm.com/tutorials/l-vim-script-5 for the inspiration.
create_autocmd("FocusGained", {
    pattern = "*",
    callback = function()
        o.cursorline = true
        cmd("redraw")
        defer_fn(function()
            o.cursorline = false
            cmd("redraw")
        end, 600)
    end,
    group = telemachus_augroup,
})

-- Format on save using conform.nvim.
create_autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
    group = telemachus_augroup,
})

-- Open quickfix window automatically.  TODO: add items to pattern.
create_autocmd("QuickFixCmdPost", {
    pattern = "cgetexpr",
    command = ":cwindow",
    group = telemachus_augroup,
})

-- Open location list window automatically.  TODO: add items to pattern.
create_autocmd("QuickFixCmdPost", {
    pattern = "lgetexpr",
    command = ":lwindow",
    group = telemachus_augroup,
})

-- Open quickfix window after refinery.nvim adds items to it.
create_autocmd("User", {
    pattern = "RefineryQuickFixCmdPost",
    command = ":cwindow",
    group = telemachus_augroup,
})

-- Update helptags after Paq installs or updates plugins.
create_autocmd("User", {
    pattern = "PaqDone*",
    command = ":helptags ALL",
    group = telemachus_augroup,
})

-- -- Global configuration when an LSP attaches.
-- create_autocmd("LspAttach", {
--     callback = function(args)
--         -- Do not let the LSP set formatexpr since some LSPs (e.g., gopls) don't
--         -- support reformatting comments.
--         bo[args.buf].formatexpr = nil
--
--         -- Disable color, completion, and semantic tokens.
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client and client.server_capabilities then
--             client.server_capabilities.colorProvider = nil
--             client.server_capabilities.completionProvider = nil
--             client.server_capabilities.semanticTokensProvider = nil
--         end
--
--         -- TODO: Remove as redundant?
--         -- Do not highlight color references in the buffer.
--         lsp.document_color.enable(false, args.buf)
--
--         -- Set keymaps.
--         local keymap_opts = { remap = false, silent = true, buffer = args.buf }
--
--         -- Jump to definition of item under cursor.
--         keymap_set("n", "gd", lsp.buf.definition, keymap_opts)
--         -- Jump to definition of item under cursor, but in a split.
--         keymap_set("n", "gs", "<C-w>]", keymap_opts)
--         -- Start rename action for item under cursor.
--         keymap_set("n", "R", lsp.buf.rename, keymap_opts)
--         -- Go to the definition of the type under cursor.
--         keymap_set("n", "T", lsp.buf.type_definition, keymap_opts)
--         -- Show signature help for current function.
--         keymap_set("i", "<C-k>", lsp.buf.signature_help, keymap_opts)
--     end,
--     group = telemachus_augroup,
-- })
--
-- -- Call goimports via gopls on write.
-- create_autocmd("BufWritePre", {
--     pattern = "*.go",
--     callback = function()
--         local params = lsp.util.make_range_params(0, "utf-16")
--         params.context = { only = { "source.organizeImports" } }
--         local result =
--             lsp.buf_request_sync(0, "textDocument/codeAction", params)
--         for cid, res in pairs(result or {}) do
--             for _, r in pairs(res.result or {}) do
--                 if r.edit then
--                     local client = lsp.get_client_by_id(cid) or {}
--                     local enc = client.offset_encoding or "utf-16"
--                     lsp.util.apply_workspace_edit(r.edit, enc)
--                 end
--             end
--         end
--     end,
--     group = telemachus_augroup,
-- })

-- Highlight on yank!
create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        on_yank({ higroup = "Visual", timeout = 300 })
    end,
    group = telemachus_augroup,
})

-- Tweak highlighting of file names in diff output.
-- See the following discussion for why this is not a Treesitter default.
-- https://bit.ly/41RT1OM
create_autocmd("FileType", {
    pattern = { "diff", "gitcommit" },
    -- The following is very brittle, but Good Enough for Now™.
    callback = function()
        -- Match old filenames (a/path/to/file)
        vim.fn.matchadd("DiffChange", "\\<a/[^ \t\r\n]\\+")

        -- Match new filenames (b/path/to/file)
        vim.fn.matchadd("DiffAdd", "\\<b/[^ \t\r\n]\\+")
    end,
    group = telemachus_augroup,
})
