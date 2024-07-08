local _should_swap = function(s_pos, e_pos)
    -- 1. If s_pos is on a line below e_pos, they are reversed.
    if s_pos[2] > e_pos[2] then
        return true
    end
    -- 2. If s_pos and e_pos are on the same line, and s_pos
    --    is in a later column, they are reversed.
    if s_pos[2] == e_pos[2] and s_pos[3] > e_pos[3] then
        return true
    end
    -- 3. If s_pos is on an earlier line than e_pos or the same line
    --    but an earlier column, they are not reversed.
    return false
end

local function replace()
    local s_pos = vim.fn.getpos("v")
    local e_pos = vim.fn.getpos(".")
    -- Depending on where the cursor is, s_pos may initially refer to
    -- the end of the visual selection, and e_pos may initially refer
    -- to the start. If so, we swap their values.
    if _should_swap(s_pos, e_pos) then
        s_pos, e_pos = e_pos, s_pos
    end

    local date = os.date("%d.%m.%Y")

    vim.api.nvim_buf_set_text(
        s_pos[1],
        s_pos[2] - 1,
        s_pos[3] - 1,
        e_pos[2] - 1,
        e_pos[3],
        { date }
    )
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
        "x",
        false
    )
end

return {
    replace = replace,
}
