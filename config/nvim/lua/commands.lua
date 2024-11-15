local create_user_command = vim.api.nvim_create_user_command

---Reload paq without restarting neovim.
create_user_command("RePaq", function(opts)
    local commands = {
        clean = "PaqClean",
        install = "PaqInstall",
        sync = "PaqSync",
        update = "PaqUpdate",
    }
    package.loaded["paq"] = nil
    package.loaded["packages"] = nil
    require("paq")(require("packages"))
    if opts.fargs[1] and commands[opts.fargs[1]] then
        vim.cmd(commands[opts.fargs[1]])
    end
end, { bar = true, nargs = "?", desc = "Reload paq without restarting neovim" })
