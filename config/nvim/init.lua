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

local packages = require("packages")
require("paq")(packages)

-- https://github.com/dstein64/vim-startuptime
g.startuptime_tries = 10

o.scrolloff = 0
o.number = true
o.relativenumber = true
o.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} "
o.completeopt = "menuone,noinsert,preview"
o.signcolumn = "yes"
o.mouse = ""

o.showcmd = true
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
o.gdefault = true
o.incsearch = true
o.hlsearch = false
o.conceallevel = 0
o.concealcursor = ""

o.backup = true
o.backupcopy = "yes"
o.backupdir = HOME .. "/.local/share/nvim/backups"
o.undofile = true
o.undodir = HOME .. "/.local/share/nvim/undo"

o.wildmode = join({ "longest", "list" }, ",")
o.wildignore = join({
    "__pycache__",
    "*~",
    "*DS_Store*",
    "*.o",
    "*.obj",
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

-- TODO: remove this dependency and create a simpler theme for myself.
local theme_loaded = safe_setup("github-theme", {
    theme_style = "light",
    sidebars = { "qf", "lf" },
    comment_style = "NONE",
    keyword_style = "NONE",
    function_style = "NONE",
    variable_style = "NONE",
    hide_end_of_buffer = false,
    hide_inactive_statusline = false,
    dark_float = true,
    dark_sidebar = true,
    transparent = true,
    overrides = function(c)
        return {
            Conceal = { fg = c.fg },
        }
    end,
})
if theme_loaded then
    cmd("colorscheme github_light")
else
    cmd("colorscheme off")
end

o.colorcolumn = "89"

o.iskeyword = o.iskeyword .. ",-"

o.grepprg = "rg --vimgrep --smart-case --"

-- https://github.com/dcampos/nvim-snippy.git
safe_setup("snippy", {
    scopes = {
        lua = function(scopes)
            if vim.api.nvim_buf_get_name(0):find("_spec.lua$") then
                table.insert(scopes, "busted")
            end
            return scopes
        end,
    },
    mappings = {
        is = {
            ["<Tab>"] = "expand_or_advance",
            ["<S-Tab>"] = "previous",
        },
        nx = {
            ["<Tab>"] = "cut_text",
        },
    },
})

-- https://github.com/nvim-treesitter/nvim-treesitter.git
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
safe_setup("nvim-treesitter.configs", {
    ensure_installed = {
        "awk",
        "bash",
        "c",
        "css",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "markdown",
        "markdown_inline",
        "lua",
        "python",
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
        go = { "gofumpt" },
        lua = { "stylua" },
        python = { "isort", "black" },
        sh = { "shfmt" },
    },
    formatters = {
        shfmt = {
            prepend_args = { "-ci", "-s", "-i", "4" },
        },
    },
})

-- https://github.com/neovim/nvim-lspconfig.git
local lsp_loaded, lspconfig = safe_require("lspconfig")
if lsp_loaded then
    lspconfig.gopls.setup({ settings = { gofumpt = true } })
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
                    },
                },
                format = {
                    enable = false,
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

-- https://github.com/echasnovski/mini.surround
safe_setup("mini.surround", {
    silent = true,
})

-- https://github.com/telemachus/refinery.nvim.git
safe_setup("refinery", {
    linters = { "golangcilint", "luacheck", "shellcheck", "vint" },
    -- For testing refinery.nvim
    -- linters = {
    --     golangcilint = {},
    --     shellcheck = { executable = HOME .. "/bin/shellcheck" },
    --     luacheck = {},
    --     vint = {},
    --     foobar = {},
    -- },
})

-- https://github.com/ysmb-wtsg/in-and-out.nvim
safe_setup("in-and-out", {
    additional_targets = { "|", "“", "”" },
})

-- https://github.com/hrsh7th/nvim-cmp
local cmp_loaded, cmp = safe_require("cmp")
if cmp_loaded then
    cmp.setup.filetype({ "markdown", "mail", "text" }, {
        mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<C-y>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            ["C-n"] = cmp.mapping.select_next_item({
                behavior = cmp.SelectBehavior.Insert,
            }),
            ["C-p"] = cmp.mapping.select_prev_item({
                behavior = cmp.SelectBehavior.Insert,
            }),
        }),
        completion = { keyword_length = 4 },
        sources = cmp.config.sources({ { name = "buffer" } }),
        window = { documentation = cmp.config.disable },
    })
end

safe_require("filetypes")
safe_require("lsp")
safe_require("autocommands")
safe_require("mappings")
