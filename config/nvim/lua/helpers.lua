local col = vim.fn.col
local getline = vim.fn.getline
local substring = string.sub

local needs_left_curly = function()
    local prev_col = col(".") - 1
    if prev_col == 0 then
        return true
    end
    local prev_char = substring(getline("."), prev_col, prev_col)
    if prev_char == " " or prev_char == "(" then
        return true
    end
    return false
end

return {
    needs_left_curly = needs_left_curly,
}
