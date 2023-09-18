-- Lua configuration for neovim
local HOME = os.getenv("HOME")
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.keymap.set
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

-- Experiment with filetype.lua and shut off filetype.vim
-- g.do_filetype_lua = 1
-- g.did_load_filetypes = 0

-- Stop vim-sandwich from stomping on s (sentence) text objects.
-- g.textobj_sandwich_no_default_key_mappings = 1

local dont_load = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "logiPat",
    -- 'matchparen',
    "netrwFileHandlers",
    "netrwPlugin",
    "netrwSettings",
    "rrhelper",
    "sql_completion",
    "syntaxcompletion",
    "loaded_tar",
    "loaded_tarPlugin",
    "loaded_vimball",
    "loaded_vimballPlugin",
    "zip",
    "zipPlugin",
}
for _, plugin in pairs(dont_load) do
    g["loaded_" .. plugin] = 1
end

require("paq")({
    "savq/paq-nvim",
    "dcampos/nvim-snippy",
    "dstein64/vim-startuptime",
    "farmergreg/vim-lastplace",
    "kylechui/nvim-surround",
    "lambdalisue/suda.vim",
    "lukas-reineke/indent-blankline.nvim",
    "m4xshen/autoclose.nvim",
    "neovim/nvim-lspconfig",
    "numToStr/Comment.nvim",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter",
    {
        "https://github.com/telemachus/github-nvim-theme",
        branch = "pinned",
        pin = true,
    },
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/tpope/vim-markdown",
    "https://github.com/tpope/vim-repeat",
})

-- https://github.com/dstein64/vim-startuptime
g.startuptime_tries = 10

cmd("syntax enable")
cmd("filetype plugin indent on")
opt.autoindent = true
opt.backspace = "indent,eol,start"
opt.history = 500
opt.scrolloff = 0
opt.number = false
opt.mouse = ""

opt.ruler = true
opt.showcmd = true
opt.showmode = true
opt.laststatus = 2

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

opt.hidden = true
opt.title = true
opt.shortmess = "atIF"
opt.statusline =
    "[%<%.20f][%{&fenc==''?&enc:&fenc}]%y%m%r%h%=%([Line: %l Column: %c %P]%)"

opt.spelllang = "en"

opt.termguicolors = true
opt.background = "light"
-- cmd('colorscheme off')
require("github-theme").setup({
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
cmd("colorscheme github_light")
opt.colorcolumn = "89"

opt.iskeyword = opt.iskeyword + "-"

opt.grepprg = "rg --vimgrep --smart-case --"

-- https://github.com/dcampos/nvim-snippy.git
require("snippy").setup({
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
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "css",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
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
                ["aF"] = "@fullfunc",
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
require("indent_blankline").setup({
    show_current_context = true,
})

-- https://github.com/stevearc/conform.nvim.git
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofumpt" },
    },
})

-- https://github.com/neovim/nvim-lspconfig.git
require("lspconfig").gopls.setup({
    settings = { gofumpt = true },
})

-- https://github.com/m4xshen/autoclose.nvim.git
require("autoclose").setup({ options = { disable_command_mode = true } })

-- https://github.com/numToStr/Comment.nvim.git
require("Comment").setup({})

-- https://github.com/kylechui/nvim-surround.git
require("nvim-surround").setup({
    keymaps = {
        normal = "sa",
        delete = "sd",
        change = "sr",
    },
})

require("filetypes")
require("lsp")
require("autocommands")
require("mappings")
