local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd
local notify = vim.notify

---Clone Paq if it is not already present.
---@return boolean # Was Paq already installed?
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
    return false
end

---Install paq itself if needed and return paq object to install other plugins.
---@return table|nil paq Paq module
---@return boolean first_install Whether or not Paq itself was installed
local function bootstrap_paq()
    local first_install = clone_paq()
    cmd.packadd("paq-nvim")
    local paq_loaded, paq = pcall(require, "paq")
    local packages_loaded, packages = pcall(require, "packages")
    if not paq_loaded or not packages_loaded then
        return nil, false
    end
    paq(packages)
    return paq, first_install
end

---Bootstrap Paq if necessary and install plugins with Paq.
---paq.install() is async; use autocommand to wait until it's done.
local function install()
    autocmd("User", {
        pattern = "PaqDoneInstall",
        callback = function()
            notify(" headless: install done\n")
            cmd("quit")
        end,
    })
    local paq, first_install = bootstrap_paq()
    if paq == nil then
        return
    end
    if first_install then
        notify("Installing plugins... If prompted, hit Enter to continue.")
    end
    paq.install()
end

---Update plugins with Paq.
---paq.update() is async; use autocommand to wait until it's done.
local function update()
    autocmd("User", {
        pattern = "PaqDoneUpdate",
        callback = function()
            notify("\n headless: update done\n")
            cmd("quit")
        end,
    })
    local paq_loaded, paq = pcall(require, "paq")
    local packages_loaded, packages = pcall(require, "packages")
    if not paq_loaded or not packages_loaded then
        return
    end
    paq(packages)
    paq.update()
end

---Remove unregistered plugins with Paq.
---paq.clean() is not async, so we don't need an autocommand.
local function clean()
    local paq_loaded, paq = pcall(require, "paq")
    local packages_loaded, packages = pcall(require, "packages")
    if not paq_loaded or not packages_loaded then
        return
    end
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
