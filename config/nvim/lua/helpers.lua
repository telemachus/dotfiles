local col = vim.fn.col
local getline = vim.fn.getline
local matchstr = vim.fn.matchstr

-- Characters after which a quote opens rather than closes. An empty
-- string means the cursor is at the start of the line.
local opens_quote = {
    [""] = true,
    [" "] = true,
    ["\t"] = true,
    ["("] = true,
    ["["] = true,
    ["{"] = true,
    ["“"] = true,
    ["‘"] = true,
    ["—"] = true,
    ["-"] = true,
    ["/"] = true,
}

local needs_left_curly = function()
    -- Match the whole (possibly multibyte) character before the cursor.
    local prev_char = matchstr(getline("."), ".\\%" .. col(".") .. "c")
    return opens_quote[prev_char] == true
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

---Safely require a module.
---@param m string
---@return boolean ok
---@return any loaded_m
local safe_require = function(m)
    local ok, loaded_m = pcall(require, m)
    if not ok then
        -- Keep only the first line, since a missing module's error lists
        -- every path that require searched.
        local msg = tostring(loaded_m):match("^[^\n]*")
        vim.notify(
            string.format([[error loading "%s": %s]], m, msg),
            vim.log.levels.ERROR
        )
    end
    return ok, loaded_m
end

return {
    needs_left_curly = needs_left_curly,
    concat_table = concat_table,
    safe_require = safe_require,
}
