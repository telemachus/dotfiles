local bo = vim.bo
local join = table.concat

bo.tabstop = 8
bo.softtabstop = 8
bo.shiftwidth = 8
bo.expandtab = false
bo.cinoptions = bo.cinoptions .. join({ "l1", "t0", "+4", "(0", ":0" }, ",")
