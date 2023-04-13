-- Lua configuration for neovim
local HOME = os.getenv('HOME')
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.keymap.set
local opt = vim.opt

g.mapleader = ' '
g.localmapleader = ' '

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
g.textobj_sandwich_no_default_key_mappings = 1

local dont_load = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'logiPat',
    -- 'matchparen',
    'netrwFileHandlers',
    'netrwPlugin',
    'netrwSettings',
    'rrhelper',
    'sql_completion',
    'syntaxcompletion',
    'loaded_tar',
    'loaded_tarPlugin',
    'loaded_vimball',
    'loaded_vimballPlugin',
    'zip',
    'zipPlugin',
}
for _, plugin in pairs(dont_load) do
    g['loaded_' .. plugin] = 1
end

cmd('syntax enable')
cmd('filetype plugin indent on')
opt.autoindent = true
opt.backspace = 'indent,eol,start'
opt.history = 500
opt.scrolloff = 0
opt.number = false
opt.mouse = ''

opt.ruler = true
opt.showcmd = true
opt.showmode = true
opt.laststatus = 2

opt.shell = 'bash'

opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.showbreak = '↪'
opt.list = true
opt.listchars = {
    eol = '↲',
    tab = '»·',
    trail = '•',
    precedes = '⟨',
    extends = '⟩',
    nbsp = '␣',
}

-- t = Autowrap text using textwidth.
-- c = Autowrap comments using textwidth.
-- q = Allow formatting of comments with 'gq'.
-- n = Recognize numbered lists for formatting purposes.
-- 1 = Do not break line after a one-letter word.
opt.formatoptions = 'tcqn1'
opt.tabstop = 8
opt.softtabstop = 0
opt.shiftwidth = 8
opt.expandtab = false
opt.foldmarker = '{{{,}}}'
opt.foldlevel = 0
opt.foldmethod = 'marker'
opt.foldenable = false

opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.incsearch = true
opt.hlsearch = false
opt.conceallevel = 0
opt.concealcursor = ''

opt.backup = true
opt.backupcopy = 'yes'
opt.backupdir = HOME .. '/.local/share/nvim/backups'
opt.undofile = true
opt.undodir = HOME .. '/.local/share/nvim/undo'

opt.wildmode = { 'longest', 'list' }
opt.wildignore = {
    '__pycache__',
    '*~',
    '*DS_Store*',
    '*.o',
    '*.obj',
    '*.png',
    '*.jpg',
    '*.jpeg',
    '*.gif',
    '*.pdf',
    '*/node_modules/*',
    '_site',
    '*/venv/*',
    '*/.log,*/.aux',
    '*/.cls,*/.aux',
    '*/.bbl',
    '*/.blg',
    '*/.fls',
    '*/.fdb*/',
    '*/.toc',
    '*/.out',
    '*/.glo',
    '*/.log',
    '*/.ist',
    '*/.fdb_latexmk',
    '*/build/*',
}

opt.hidden = true
opt.title = true
opt.shortmess = 'atIF'
opt.statusline =
    "[%<%.20f][%{&fenc==''?&enc:&fenc}]%y%m%r%h%=%([Line: %l Column: %c %P]%)"

opt.spelllang = 'en'

opt.termguicolors = true
opt.background = 'light'
-- cmd('colorscheme off')
require('github-theme').setup({
    options = {
        transparent = false,
        hide_end_of_buffer = true,
        hide_nc_statusline = false,
        styles = {
            comments = 'NONE',
            functions = 'NONE',
            keywords = 'NONE',
            variables = 'NONE',
        },
        darken = {
            floats = true,
            sidebars = {
                enable = true,
                list = { 'qf', 'lf' },
            },
        },
    },
    overrides = function(c)
        return {
            Conceal = { fg = c.fg },
        }
    end,
})
cmd('colorscheme github_light')
opt.colorcolumn = '89'

opt.iskeyword = opt.iskeyword + '-'

opt.grepprg = 'rg --vimgrep --smart-case --'

local snippy = require('snippy')
snippy.setup({
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
        nx = {
            ['<Tab>'] = 'cut_text',
        },
    },
})

local treesitterConfigs = require('nvim-treesitter.configs')
treesitterConfigs.setup({
    ensure_installed = { 'go', 'lua', 'python', 'c', 'query' },
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
                ['aF'] = '@fullfunction',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- place jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
            },
        },
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<CR>',
            show_help = '?',
        },
    },
})

local indentBlankline = require('indent_blankline')
indentBlankline.setup({
    show_current_context = true,
    show_current_context_start = true,
})

require('filetypes')
require('usercommands')
require('autocommands')
require('mappings')
