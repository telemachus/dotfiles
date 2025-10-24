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

local mt = {}
mt.__concat = function(t1, t2)
    assert(type(t1) == "table" and type(t2) == "table")
    local dict = setmetatable({}, mt)
    for k, v in pairs(t1) do
        dict[k] = v
    end
    for k, v in pairs(t2) do
        dict[k] = v
    end
    return dict
end

local concat_table = function(t)
    return setmetatable(t or {}, mt)
end

return {
    needs_left_curly = needs_left_curly,
    concat_table = concat_table,
}
