-- Lua configuration for neovim
local HOME = os.getenv("HOME")
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.localmapleader = " "

-- Don't waste time looking for various scripting providers.
-- See also this issue re UltiSnips: https://bit.ly/3w1nN9y.
-- g.python_host_skip_check = 1
-- g.python3_host_prog = fn.fnamemodify('~/', ':p') .. '.pyenv/shims/python'
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

-- cmd("syntax enable")
-- cmd("filetype plugin indent on")
-- opt.autoindent = true
-- opt.backspace = "indent,eol,start"
-- opt.history = 500
opt.scrolloff = 0
opt.number = false
opt.mouse = ""

-- opt.ruler = true
opt.showcmd = true
opt.showmode = true
-- opt.laststatus = 2

opt.shell = "bash"

opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪"
opt.list = true
opt.listchars = {
    eol = "↲",
    tab = "»·",
    trail = "•",
    precedes = "⟨",
    extends = "⟩",
    nbsp = "␣",
}

-- t = Autowrap text using textwidth.
-- c = Autowrap comments using textwidth.
-- q = Allow formatting of comments with 'gq'.
-- n = Recognize numbered lists for formatting purposes.
-- 1 = Do not break line after a one-letter word.
opt.formatoptions = "tcqn1"
opt.tabstop = 8
opt.softtabstop = 0
opt.shiftwidth = 8
opt.expandtab = false
opt.foldmarker = "{{{,}}}"
opt.foldlevel = 0
opt.foldmethod = "marker"
opt.foldenable = false

opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.incsearch = true
opt.hlsearch = false
opt.conceallevel = 0
opt.concealcursor = ""

opt.backup = true
opt.backupcopy = "yes"
opt.backupdir = HOME .. "/.local/share/nvim/backups"
opt.undofile = true
opt.undodir = HOME .. "/.local/share/nvim/undo"

opt.wildmode = { "longest", "list" }
opt.wildignore = {
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
}

-- opt.hidden = true
opt.title = true
opt.shortmess = "atIF"
opt.statusline =
    "[%<%.20f][%{&fenc==''?&enc:&fenc}]%y%m%r%h%=%([Line: %l Column: %c %P]%)"

opt.spelllang = "en"

opt.termguicolors = true
opt.background = "light"

local safe_require = function(m)
    local ok, loaded_m = pcall(require, m)
    if not ok then
        vim.notify(vim.fn.printf("init.lua: error loading %s: %s", m, ok))
    end
    return ok, loaded_m
end

local safe_setup = function(plugin, t)
    local ok, loaded_p = safe_require(plugin)
    if not ok then
        return
    end
    loaded_p.setup(t)
    return ok
end

local ok = safe_setup("github-theme", {
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
if ok then
    cmd("colorscheme github_light")
else
    cmd("colorscheme off")
end

opt.colorcolumn = "89"

opt.iskeyword = opt.iskeyword + "-"

opt.grepprg = "rg --vimgrep --smart-case --"

-- https://github.com/dcampos/nvim-snippy.git
safe_setup("snippy", {
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
        highlight = { "IndentBlanklineContextChar" },
        include = {
            node_type = {
                ["*"] = {
                    "arguments",
                    "block",
                    "bracket",
                    "declaration",
                    "expression_list",
                    "field",
                    "for",
                    "func_literal",
                    "function",
                    "if",
                    "import",
                    "list",
                    "return_statement",
                    "short_var_declaration",
                    "switch_body",
                    "try",
                    "type",
                },
            },
        },
    },
})

-- https://github.com/stevearc/conform.nvim.git
safe_setup("conform", {
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofumpt" },
    },
})

-- https://github.com/neovim/nvim-lspconfig.git
local lspconfig
ok, lspconfig = safe_require("lspconfig")
if ok then
    lspconfig.gopls.setup({ settings = { gofumpt = true } })
end

-- https://github.com/m4xshen/autoclose.nvim.git
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

-- https://github.com/numToStr/Comment.nvim.git
safe_setup("Comment", {})

-- https://github.com/kylechui/nvim-surround.git
safe_setup("nvim-surround", {
    keymaps = {
        normal = "sa",
        delete = "sd",
        change = "sr",
    },
})

safe_require("filetypes")
safe_require("lsp")
safe_require("autocommands")
safe_require("mappings")
