local join = vim.fn.join
local opt = vim.opt
local expandcmd = vim.fn.expandcmd
local fmt = string.format
local command = vim.api.nvim_command

local lua_grep = function(...)
    cmd = opt.grepprg:get() .. ' ' .. expandcmd(join({ ... }))
    ex_cmd = fmt('cexpr system("%s")', cmd)
    command(ex_cmd)
end

return {
    grep = lua_grep,
}
