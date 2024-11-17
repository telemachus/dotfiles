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

---Chdir to root of current directory if .git is found.
create_user_command("GitRoot", function(_)
    require("root").seek({ ".git" })
end, {
    bar = true,
    nargs = 0,
    desc = "Seek .git starting from $PWD and cd there if found",
})

---Chdir to root of current directory if go.mod is found.
create_user_command("GoRoot", function(_)
    require("root").seek({ "go.mod" })
end, {
    bar = true,
    nargs = 0,
    desc = "Seek go.mod starting from $PWD and cd there if found",
})

---Chdir to root of current directory if an item in opts.fargs is found.
create_user_command("Root", function(opts)
    require("root").seek(opts.fargs)
end, {
    bar = true,
    nargs = "+",
    desc = "Seek requested targets starting from $PWD and cd there if found",
})
