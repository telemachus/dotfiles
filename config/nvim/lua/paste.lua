local linewise_above = function()
    local body = vim.fn.getreg(vim.v.register)
    body = vim.fn["repeat"]({ body }, vim.v.count1)
    local linenr = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, linenr - 1, linenr - 1, true, body)
end

local linewise_below = function()
    local body = vim.fn.getreg(vim.v.register)
    body = vim.fn["repeat"]({ body }, vim.v.count1)
    local linenr = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, linenr, linenr, true, body)
end

return {
    linewise_above = linewise_above,
    linewise_below = linewise_below,
}
