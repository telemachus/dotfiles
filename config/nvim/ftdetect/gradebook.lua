vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.gradebook",
    command = "set filetype=json",
})
