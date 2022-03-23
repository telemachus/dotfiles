-- Lua configuration for neovim
local HOME = os.getenv('HOME')
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.keymap.set
local opt = vim.opt

-- Don't waste time looking for various scripting providers.
-- See also this issue re UltiSnips: https://bit.ly/3w1nN9y.
-- g.python_host_skip_check = 1
-- g.python3_host_prog = fn.fnamemodify('~/', ':p') .. '.pyenv/shims/python'
g.loaded_python3_provider = 0
g.loaded_python_provider = 0
g.loaded_node_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

local dont_load = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'logiPat',
    'matchparen',
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

opt.background = 'light'
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

opt.shell = bash

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
    nbsp = '␣'
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

opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.incsearch = true
opt.hlsearch = false
opt.conceallevel = 0

opt.backup = true
opt.backupcopy = 'yes'
opt.backupdir = HOME .. '/.nvim_backups'
opt.undofile = true
opt.undodir = HOME .. '/.nvim_undo'

opt.wildmode = {'longest', 'list'}
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
opt.statusline = "[%<%.20f][%{&fenc==''?&enc:&fenc}]%y%m%r%h%=%([Line: %l Column: %c %P]%)"

opt.termguicolors = true
cmd('colorscheme off')
opt.colorcolumn = '89'

opt.iskeyword = opt.iskeyword + '-'
g.mapleader = ','
g.localmapleader = '\\'

opt.grepprg = 'rg --hidden --vimgrep --smart-case --'

require('go').setup({
    -- auto commands
    auto_format = true,
    -- formatter: goimports, gofmt, gofumpt
    formatter = 'goimports',
    auto_lint = true,
    -- linters: revive, errcheck, staticcheck, golangci-lint
    linter = 'revive',
    -- linter_flags: e.g., {revive = {'-config', '/path/to/config.yml'}}
    linter_flags = {},
    -- lint_prompt_style: qf (quickfix), vt (virtual text)
    lint_prompt_style = 'qf',
})

local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')

luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = false,
}

local t = function(str)
    return api.nvim_replace_termcodes(str, true, true, true)
end

map(
    {'i', 's'},
    '<C-K>',
    function()
        if luasnip and luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        end
    end,
    {silent = true}
)

map(
    {'i', 's'},
    '<C-J>',
    function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end,
    {silent = true}
)

map(
    'i',
    '<C-L>',
    function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end,
    {silent = true}
)

-- require('luasnip.loaders.from_snipmate').lazy_load()
