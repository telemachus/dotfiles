-- From unimpaired.nvim
--
-- If a mapped function calls a dot-repeatable normal command, then the mapped
-- function will lose its dot-repeatable status.
--
-- This function, which must be called last inside of a mapped function, will
-- restore dot-repetition to the mapped function itself.
local restore_dot_repetition = function(count)
    count = count or ""
    local callback = vim.go.operatorfunc
    vim.go.operatorfunc = ""
    vim.cmd("silent! normal! " .. count .. "g@l")
    vim.go.operatorfunc = callback
end

-- https://vim.fandom.com/wiki/Unconditional_linewise_or_characterwise_paste
local adjust_paste = function(reg_name, paste_type, paste_cmd, count)
    local reg_type = vim.fn.getregtype(reg_name)
    local body = vim.fn.getreg(reg_name)
    vim.fn.setreg(reg_name, body, paste_type)
    local cmd = 'normal! "' .. reg_name .. count .. paste_cmd
    vim.cmd(cmd)
    vim.fn.setreg(reg_name, body, reg_type)
end

local linewise_above = function()
    local count = vim.v.count1
    adjust_paste(vim.v.register, "l", "P", count)
    restore_dot_repetition(count)
end

local linewise_below = function()
    local count = vim.v.count1
    adjust_paste(vim.v.register, "l", "p", count)
    restore_dot_repetition(count)
end

local charwise_above = function()
    local count = vim.v.count1
    adjust_paste(vim.v.register, "v", "P", count)
    restore_dot_repetition(count)
end

local charwise_below = function()
    local count = vim.v.count1
    adjust_paste(vim.v.register, "v", "p", count)
    restore_dot_repetition(count)
end

return {
    linewise_above = linewise_above,
    linewise_below = linewise_below,
    charwise_above = charwise_above,
    charwise_below = charwise_below,
}
