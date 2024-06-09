-- bitly.lua provides a function to shorten URLs using a local bitly command.
local system = vim.fn.system
local trim = vim.fn.trim
local replace_termcodes = vim.api.nvim_replace_termcodes
local feedkeys = vim.api.nvim_feedkeys
local getpos = vim.fn.getpos
local getregion = vim.fn.getregion
local buf_set_text = vim.api.nvim_buf_set_text

local _bitly_cmd = function(url)
    url = system({ "bitly", "-stdout", "-url", url })
    return trim(url)
end

--- Shorten a visually selected URL.
local shorten = function()
    local start_pos = getpos("v")
    local end_pos = getpos(".")
    -- If the cursor is at the start of the visual selection, start_pos
    -- and end_pos will be reversed. Swap them if that's the case.
    if start_pos[3] > end_pos[3] then
        start_pos, end_pos = end_pos, start_pos
    end

    local strings = getregion(start_pos, end_pos)
    if #strings < 1 then
        return
    end
    local url = _bitly_cmd(strings[1])
    if url == "" then
        return
    end

    -- buf_set_text takes six arguments.
    --     1. A buffer number
    --     2. The starting row (i.e., line)
    --     3. The starting column
    --     4. The ending row
    --     5. The ending column
    --     6. A list of strings to insert
    --
    --     Row and column indices start from zero, so we need to subtract
    --     one from the results of getpos. End indices for rows are inclusive,
    --     but end indices for columns are exclusive. Hence, we don't adjust
    --     the fifth argument.
    buf_set_text(
        start_pos[1],
        start_pos[2] - 1,
        start_pos[3] - 1,
        end_pos[2] - 1,
        end_pos[3],
        { url }
    )
    feedkeys(replace_termcodes("<Esc>", true, false, true), "x", false)
end

return {
    shorten = shorten,
}
