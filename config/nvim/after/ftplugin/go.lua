local bo = vim.bo

-- By default vim and neovim set formatprg to gofmt for go files. Unfortunately,
-- if formatprg is set, then gq and Q no longer format comments.
bo.formatprg = ""
