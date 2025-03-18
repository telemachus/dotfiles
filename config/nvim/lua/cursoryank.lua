local cursor_pre_yank
local keymap_set = vim.keymap.set
local win_get_cursor = vim.api.nvim_win_get_cursor
local win_set_cursor = vim.api.nvim_win_set_cursor
local create_autocmd = vim.api.nvim_create_autocmd

keymap_set({ "n", "x" }, "y", function()
    cursor_pre_yank = win_get_cursor(0)
    return "y"
end, { expr = true })

keymap_set("n", "Y", function()
    cursor_pre_yank = win_get_cursor(0)
    return "y$"
end, { expr = true })

create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" and cursor_pre_yank then
            win_set_cursor(0, cursor_pre_yank)
        end
    end,
})
