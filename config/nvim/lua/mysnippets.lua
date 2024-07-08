local keymap_set = vim.keymap.set
local default_opts = { remap = false, silent = true }
local api = vim.api

local global_snippets = {
    {
        prefix = "hw",
        body = "${1:${TM_FILENAME:hello}} ${2:${TM_SELECTED_TEXT:cruel}} ${3:world} !$0",
    },
    {
        prefix = "yolo",
        body = "You only live ${1:${TM_FILENAME_BASE:once}}.$0",
    },
}

local snippets_by_filetype = {}

local function get_buf_snips()
    local ft = vim.bo.filetype
    local snips = vim.list_slice(global_snippets)

    if ft and snippets_by_filetype[ft] then
        vim.list_extend(snips, snippets_by_filetype[ft])
    end

    return snips
end

local function get_snippet()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local cur_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)
    local line_pre_cursor = cur_line[1]:sub(1, col)

    for _, s in ipairs(get_buf_snips()) do
        if vim.endswith(line_pre_cursor, s.prefix) then
            return s.prefix, s.body, line, col
        end
    end

    return nil
end

local function expand_under_cursor()
    local prefix, body, line, col = get_snippet()
    if not prefix or not line or not col then
        return false
    end
    -- remove prefix
    vim.api.nvim_buf_set_text(0, line - 1, col - #prefix, line - 1, col, {})
    vim.api.nvim_win_set_cursor(0, { line, col - #prefix })
    vim.snippet.expand(body)
    return true
end

keymap_set({ "i" }, "<Tab>", function()
    if vim.snippet.active({ direction = 1 }) then
        vim.schedule(function()
            vim.snippet.jump(1)
        end)
        return
    elseif expand_under_cursor() then
        return
    else
        api.nvim_feedkeys(
            api.nvim_replace_termcodes("<Tab>", true, true, true),
            "n",
            true
        )
    end
end, default_opts)

keymap_set({ "s" }, "<Tab>", function()
    vim.schedule(function()
        vim.snippet.jump(1)
    end)
end, default_opts)

keymap_set({ "i", "s" }, "<S-Tab>", function()
    if vim.snippet.active({ direction = -1 }) then
        vim.schedule(function()
            vim.snippet.jump(-1)
        end)
        return
    else
        api.nvim_feedkeys(
            api.nvim_replace_termcodes("<S-Tab>", true, true, true),
            "n",
            true
        )
    end
end, default_opts)
