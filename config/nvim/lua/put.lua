-- From unimpaired.nvim
-- https://github.com/tummetott/unimpaired.nvim
--
-- If a mapped function calls a dot-repeatable normal command, then the mapped
-- function will lose its dot-repeatable status.
--
-- This function, which must be called last inside of a mapped function, will
-- restore dot-repetition to the mapped function itself.
local _restore_dot_repetition = function(count)
    count = count or ""
    local callback = vim.go.operatorfunc
    vim.go.operatorfunc = ""
    vim.cmd("silent! normal! " .. count .. "g@l")
    vim.go.operatorfunc = callback
end

-- Sometimes you yank text charwise but you want to put the text on its own line
-- (linewise, as vim calls it).  However, when vim copies text into a register,
-- it also sets *how* the text was copied, and this setting is sticky.  That is,
-- if you copy charwise, then any placement from that register will be charwise.
-- If you copy linewise, then any placement from that register will be linewise.
-- This function allows you to separate the placement mode from the placement
-- mode.  Thus, you can yank charwise and place linewise.  (You can also use the
-- function to copy linewise and then place them within a line, but I rarely
-- want to do that.)
--
-- See ":help setreg" for reasonable values of put_mode.  (In practical terms,
-- you probably want "l" or "c".)
--
-- For put_cmd, "P" will put text before the cursor (i.e., above the cursor if
-- the mode is linewise), and "p" will put text after the cursor (i.e., below if
-- the mode is linewise).
--
-- See the following for inspiration:
-- https://vim.fandom.com/wiki/Unconditional_linewise_or_characterwise_paste
-- https://github.com/tpope/vim-unimpaired/
local _adjust_put = function(put_mode, put_cmd, count)
    local reg_type = vim.fn.getregtype(vim.v.register)
    local body = vim.fn.getreg(vim.v.register)
    -- By adding ] to the put command, we get automatic indentation.  See `help
    -- ]p`.
    put_cmd = "]" .. put_cmd
    vim.fn.setreg(vim.v.register, body, put_mode)
    vim.cmd('normal! "' .. vim.v.register .. count .. put_cmd)
    vim.fn.setreg(vim.v.register, body, reg_type)
end

local linewise_above = function()
    local count = vim.v.count1
    _adjust_put("l", "P", count)
    _restore_dot_repetition(count)
end

local linewise_below = function()
    local count = vim.v.count1
    _adjust_put("l", "p", count)
    _restore_dot_repetition(count)
end

return {
    linewise_above = linewise_above,
    linewise_below = linewise_below,
}
