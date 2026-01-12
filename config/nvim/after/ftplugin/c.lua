local bo = vim.bo
local join = table.concat

bo.tabstop = 4
bo.softtabstop = 4
bo.shiftwidth = 4
bo.expandtab = false
bo.cinoptions = bo.cinoptions .. join({ "l1", "t0", "+4", "(0", ":0" }, ",")
