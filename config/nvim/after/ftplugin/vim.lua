local bo = vim.bo

bo.tabstop = 8
bo.softtabstop = 4
bo.shiftwidth = 4
-- See :help ft-vim-indent; default is shiftwidth() * 3, which is far too much.
-- indent/vim.vim reads this at indent time, so keep it equal to shiftwidth.
vim.g.vim_indent_cont = vim.fn.shiftwidth()
bo.expandtab = true
bo.commentstring = '" %s'
