local create_user_command = vim.api.nvim_create_user_command

---Reload paq without restarting neovim.
create_user_command("RePaq", function(opts)
    local commands = {
        install = "PaqInstall",
        remove = "PaqRemove",
        sync = "PaqSync",
        clean = "PaqClean",
    }
    package.loaded["paq"] = nil
    package.loaded["packages"] = nil
    require("paq")(require("packages"))
    if opts.fargs[1] and commands[opts.fargs[1]] then
        vim.cmd(commands[opts.fargs[1]])
    end
end, { nargs = "?", desc = "Reload paq without restarting neovim." })
