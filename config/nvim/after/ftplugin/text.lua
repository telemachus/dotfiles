local bo = vim.bo
local wo = vim.wo

bo.comments = ""
bo.formatoptions = "1tnw"
bo.textwidth = 80
wo.list = true
wo.spell = true
bo.formatprg = "par -w80q"
vim.b.match_words = { '":"', "':'", "(:)", "[:]", "<:>", "“:”", "‘:’" }

vim.keymap.set("i", '"', function()
    if require("helpers").needs_left_curly() then
        return "“"
    else
        return "”"
    end
end, { remap = false, silent = true, expr = true, buffer = true })

vim.keymap.set("i", "'", function()
    if require("helpers").needs_left_curly() then
        return "‘"
    else
        return "’"
    end
end, { remap = false, silent = true, expr = true, buffer = true })
