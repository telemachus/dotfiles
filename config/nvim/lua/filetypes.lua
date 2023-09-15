local filetype = vim.filetype.add
local search = vim.fn.search

filetype({
    extension = {
        -- Taken from https://bit.ly/3xyaUEr
        h = function(_, _)
            if search("\\C^#include <[^>.]\\+>$", "nw") ~= 0 then
                return "cpp"
            end
            return "c"
        end,
        rockspec = "lua",
    },
})
