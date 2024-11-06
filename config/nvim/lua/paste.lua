-- https://vim.fandom.com/wiki/Unconditional_linewise_or_characterwise_paste
local adjust_paste = function(reg_name, paste_type, paste_cmd)
    local reg_type = vim.fn.getregtype(reg_name)
    vim.fn.setreg(reg_name, vim.fn.getreg(reg_name), paste_type)
    local cmd = '"' .. reg_name .. paste_cmd
    vim.cmd.normal(cmd)
    vim.fn.setreg(reg_name, vim.fn.getreg(reg_name), reg_type)
end

local linewise_above = function()
    adjust_paste(vim.v.register, "l", "P")
end

local linewise_below = function()
    adjust_paste(vim.v.register, "l", "p")
end

local charwise_above = function()
    adjust_paste(vim.v.register, "v", "P")
end

local charwise_above = function()
    adjust_paste(vim.v.register, "v", "P")
end

return {
    linewise_above = linewise_above,
    linewise_below = linewise_below,
    charwise_above = charwise_above,
    charwise_below = charwise_below,
}
