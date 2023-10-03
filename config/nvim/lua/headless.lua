local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd
local notify = vim.notify

local function clone_paq()
    local path = fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
    local is_installed = fn.empty(vim.fn.glob(path)) == 0
    if not is_installed then
        fn.system({
            "git",
            "clone",
            "--depth=1",
            "https://github.com/savq/paq-nvim.git",
            path,
        })
        return true
    end
end

local function bootstrap_paq()
    local first_install = clone_paq()
    cmd.packadd("paq-nvim")
    local paq = require("paq")
    local packages = require("packages")
    paq(packages)
    return paq, first_install
end

-- paq.install() is async; use autocommand to wait until it's done.
local function install()
    autocmd("User", {
        pattern = "PaqDoneInstall",
        callback = function()
            notify(" headless: install done\n")
            cmd("quit")
        end,
    })
    local paq, first_install = bootstrap_paq()
    -- Read and install packages
    if first_install then
        notify("Installing plugins... If prompted, hit Enter to continue.")
    end
    paq.install()
    return paq
end

-- paq.update() is async; use autocommand to wait until it's done.
local function update()
    autocmd("User", {
        pattern = "PaqDoneUpdate",
        callback = function()
            notify("\n headless: update done\n")
            cmd("quit")
        end,
    })
    local paq = require("paq")
    local packages = require("packages")
    paq(packages)
    paq.update()
end

-- paq.clean() is not async, so we don't need an autocommand.
local function clean()
    local paq = require("paq")
    local packages = require("packages")
    paq(packages)
    paq.clean()
    notify(" headless: clean done\n")
    cmd("quit")
end

return {
    install = install,
    update = update,
    clean = clean,
}
