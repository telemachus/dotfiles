-- Lua configuration for neovim
vim.loader.enable()
local HOME = os.getenv("HOME")
local cmd = vim.cmd
local g = vim.g
local o = vim.o
local join = table.concat
local fmt = string.format
local notify = vim.notify

g.mapleader = " "
g.localmapleader = " "

-- Don't waste time looking for various scripting providers.
-- See also this issue re UltiSnips: https://bit.ly/3w1nN9y.
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

local dont_load = {
    "gzip",
    "matchit",
    "matchparen",
    "netrwPlugin",
    "rplugin",
    "tarPlugin",
    "tohtml",
    "tutor",
    "zipPlugin",
}
for _, plugin in pairs(dont_load) do
    g["loaded_" .. plugin] = 1
end

-- https://github.com/dstein64/vim-startuptime
g.startuptime_tries = 10

o.background = "light"
o.cpo = o.cpo .. "J"
o.joinspaces = true

o.scrolloff = 0
o.number = true
o.relativenumber = true
o.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} "
o.completeopt = "menuone,noinsert,preview"
o.signcolumn = "yes"
o.mouse = ""

o.showcmd = false
o.showmode = true

o.shell = "bash"

o.wrap = true
o.linebreak = true
o.breakindent = true
o.showbreak = "↪"
o.list = true
o.listchars = join({
    "eol:↲",
    "tab:»·",
    "trail:•",
    "precedes:⟨",
    "extends:⟩",
    "nbsp:␣",
}, ",")

-- t = Autowrap text using textwidth.
-- c = Autowrap comments using textwidth.
-- q = Allow formatting of comments with 'gq'.
-- n = Recognize numbered lists for formatting purposes.
-- 1 = Do not break line after a one-letter word.
o.formatoptions = "tcqn1"
o.tabstop = 8
o.softtabstop = 0
o.shiftwidth = 8
o.expandtab = false
o.foldenable = false

o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.inccommand = "split"
o.gdefault = true
o.infercase = true
o.hlsearch = false
o.conceallevel = 0
o.concealcursor = ""

o.backup = true
o.backupcopy = "yes"
o.backupdir = HOME .. "/.local/share/nvim/backups"
o.undofile = true
o.undodir = HOME .. "/.local/share/nvim/undo"
o.titlestring = '%{fnamemodify(getcwd(), ":~")} :: %{expand("%:t")}'

o.wildmode = join({ "longest", "list" }, ",")
o.wildignore = join({
    "__pycache__",
    "*~",
    "*DS_Store*",
    "*.o",
    "*.obj",
    "*.a",
    "*.lib",
    "*.elf",
    "*.png",
    "*.jpg",
    "*.jpeg",
    "*.gif",
    "*.pdf",
    "*/node_modules/*",
    "_site",
    "*/venv/*",
    "*/.log,*/.aux",
    "*/.cls,*/.aux",
    "*/.bbl",
    "*/.blg",
    "*/.fls",
    "*/.fdb*/",
    "*/.toc",
    "*/.out",
    "*/.glo",
    "*/.log",
    "*/.ist",
    "*/.fdb_latexmk",
    "*/build/*",
    "blue.vim",
    "darkblue.vim",
    "delek.vim",
    "desert.vim",
    "elflord.vim",
    "evening.vim",
    "habamax.vim",
    "industry.vim",
    "koehler.vim",
    "lunaperche.vim",
    "morning.vim",
    "murphy.vim",
    "pablo.vim",
    "peachpuff.vim",
    "quiet.vim",
    "retrobox.vim",
    "ron.vim",
    "shine.vim",
    "slate.vim",
    "sorbet.vim",
    "torte.vim",
    "wildcharm.vim",
    "zaibatsu.vim",
    "zellner.vim",
}, ",")

o.hidden = true
o.title = true
o.shortmess = "atIF"
o.statusline =
    "[%<%.20f][%{&fenc==''?&enc:&fenc}]%y%m%r%h%=%([Line: %l Column: %c %P]%)"

o.spelllang = "en"

---Safely require a module.
---@param m string
---@return boolean ok
---@return table loaded_m
local safe_require = function(m)
    local ok, loaded_m = pcall(require, m)
    if not ok then
        notify(fmt([[init.lua: error loading "%s"]], m))
    end
    return ok, loaded_m
end

---Safely call setup on a plugin.
---@param plugin string
---@param t table|nil
---@return boolean
local safe_setup = function(plugin, t)
    t = t or {}
    local ok, loaded_p = safe_require(plugin)
    if ok then
        loaded_p.setup(t)
    end
    return ok
end

o.guicursor = join({
    "n-v-c-sm:block",
    "i-ci-ve:ver100-Cursor-blinkwait800-blinkon800-blinkoff950",
    "r-cr-o:hor20",
}, ",")
cmd("colorscheme minimum")
o.colorcolumn = "+1"

o.iskeyword = o.iskeyword .. ",-"

o.grepprg = "rg --vimgrep --smart-case --"

-- https://github.com/nvim-treesitter/nvim-treesitter.git
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
safe_setup("nvim-treesitter.configs", {
    ensure_installed = {
        "awk",
        "bash",
        "c",
        "css",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "markdown",
        "markdown_inline",
        "lua",
        "python",
        "rust",
        "query",
        "vim",
        "vimdoc",
    },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- place jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
            },
        },
    },
})

-- https://github.com/lukas-reineke/indent-blankline.nvim.git
safe_setup("ibl", {
    indent = { char = "│", tab_char = "│" },
    scope = {
        show_start = false,
        show_end = false,
        include = {
            node_type = {
                -- These two provide visual cues for complex Lua tables, which
                -- are everywhere in neovim configuration.
                ["*"] = {
                    "arguments",
                    "field",
                },
            },
        },
    },
})

-- https://github.com/stevearc/conform.nvim.git
safe_setup("conform", {
    -- log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
        json = { "gojq" },
        go = { "gofumpt" },
        lua = { "stylua" },
        python = { "isort", "black" },
        sh = { "shfmt" },
        sql = { "sleek" },
        rust = { "rustfmt" },
    },
    formatters = {
        gojq = {
            command = "gojq",
            args = { "--indent", "4" },
        },
        shfmt = {
            prepend_args = { "-ci", "-s", "-i", "4" },
        },
    },
})

-- https://github.com/neovim/nvim-lspconfig.git
-- Require my LSP tweaks here since some LSP setup seems order dependent.
safe_require("lsp")
local lsp_loaded, lspconfig = safe_require("lspconfig")
if lsp_loaded then
    lspconfig.util.default_config.on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end

    -- gopls: https://github.com/golang/tools/tree/master/gopls
    lspconfig.gopls.setup({
        settings = { gofumpt = true },
        capabilities = {
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = false,
                    },
                },
            },
        },
    })

    -- lua-language-server: https://luals.github.io
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        "/Users/telemachus/Downloads/src/LLS-Addons",
                    },
                    -- TODO: find out why this does not work.
                    userThirdParty = {},
                },
                format = {
                    enable = false,
                },
                completion = {
                    callSnippet = "Disable",
                    keywordSnippet = "Disable",
                },
            },
        },
    })
end

-- https://github.com/telemachus/autoclose.nvim.git
safe_setup("autoclose", {
    options = {
        disable_command_mode = true,
    },
    keys = {
        ["“"] = {
            close = true,
            escape = false,
            pair = { "“", "”" },
            enabled_filetypes = { "markdown", "text", "mail" },
        },
        ["”"] = {
            close = false,
            escape = true,
            pair = { "“", "”" },
            enabled_filetypes = { "markdown", "text", "mail" },
        },
    },
})

-- https://github.com/telemachus/mini.surround
safe_setup("mini.surround", {
    silent = true,
})

-- https://github.com/telemachus/refinery.nvim.git
safe_setup("refinery", {
    linters = {
        "golangcilint",
        "luacheck",
        "revive",
        "shellcheck",
        "staticcheck",
        "vint",
    },
    -- For testing refinery.nvim
    -- linters = {
    --     golangcilint = {},
    --     shellcheck = { executable = HOME .. "/bin/shellcheck" },
    --     luacheck = {},
    --     vint = {},
    --     foobar = {},
    -- },
})

safe_require("filetypes")
safe_require("autocommands")
safe_require("mappings")
safe_require("commands")
safe_require("cursoryank")
