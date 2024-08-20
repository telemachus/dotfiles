-- This is a simplified version of in-and-out.nvim.
-- https://github.com/ysmb-wtsg/in-and-out.nvim
local function escape_lua_pattern(s)
    local matches = {
        ["^"] = "%^",
        ["$"] = "%$",
        ["("] = "%(",
        [")"] = "%)",
        ["%"] = "%%",
        ["."] = "%.",
        ["["] = "%[",
        ["]"] = "%]",
        ["*"] = "%*",
        ["+"] = "%+",
        ["-"] = "%-",
        ["?"] = "%?",
    }
    return s:gsub(".", matches)
end

local targets = { '"', "'", "(", ")", "{", "}", "[", "]", "`", "“", "”" }

local leap = function()
    local line_nr, col_nr = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()

    local target_col_nr = nil
    for _, char in ipairs(targets) do
        local found_col_nr =
            string.find(line, escape_lua_pattern(char), col_nr + 1)
        if
            found_col_nr and (not target_col_nr or found_col_nr < target_col_nr)
        then
            -- If char is a multibyte character, we need to take into
            -- account the extra bytes.
            target_col_nr = found_col_nr + vim.fn.strlen(char) - 1
        end
    end

    if target_col_nr then
        vim.api.nvim_win_set_cursor(0, { line_nr, target_col_nr })
    end
end

return {
    leap = leap,
}
