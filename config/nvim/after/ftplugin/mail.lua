local bo = vim.bo
local wo = vim.wo

wo.number = false
wo.relativenumber = false
wo.statuscolumn = ""
bo.comments = ""
bo.formatoptions = "1tn"
bo.textwidth = 72
wo.colorcolumn = "73"
wo.list = true
wo.spell = true
wo.signcolumn = "no"
bo.formatprg = "par -w72q"

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
