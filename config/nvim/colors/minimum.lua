--- Name: minimum
--- Description: A minimal colorscheme for neovim.
--- Author: Peter Aronoff
--- License: BSD-3-Clause
local g = vim.g
local cmd = vim.cmd

if g.colors_name ~= nil then
    cmd("highlight clear")
end
g.colors_name = "minimum"

local colors = {
    -- Terminal palette in 0-15 order.
    -- I took most of these from the following site:
    -- https://sashamaps.net/docs/resources/20-colors/
    black = "#000000",
    dark_red = "#800000",
    dark_green = "#194a1f",
    dark_yellow = "#808000",
    dark_blue = "#000075",
    dark_magenta = "#8b008b",
    dark_cyan = "#469990",
    grey = "#c5c6c8",
    dark_grey = "#737373",
    red = "#d20f2c",
    green = "#3cb44d",
    yellow = "#ffe119",
    blue = "#4363d8",
    magenta = "#f032e6",
    cyan = "#42d4f4",
    white = "#ffffff",

    -- Additional colors
    near_black = "#090909",
    light_grey = "#f0f1f3",
    light_red = "#fabed4",
    light_green = "#aaffc3",
    light_yellow = "#fffac8",
    light_blue = "#d5e5f6",
}

g.terminal_color_0 = colors.black
g.terminal_color_1 = colors.dark_red
g.terminal_color_2 = colors.dark_green
g.terminal_color_3 = colors.dark_yellow
g.terminal_color_4 = colors.dark_blue
g.terminal_color_5 = colors.dark_magenta
g.terminal_color_6 = colors.dark_cyan
g.terminal_color_7 = colors.grey
g.terminal_color_8 = colors.dark_grey
g.terminal_color_9 = colors.red
g.terminal_color_10 = colors.green
g.terminal_color_11 = colors.yellow
g.terminal_color_12 = colors.blue
g.terminal_color_13 = colors.magenta
g.terminal_color_14 = colors.cyan
g.terminal_color_15 = colors.white

local highlight_groups = {
    -- Editor (:help highlight-groups)
    ["ColorColumn"] = { bg = colors.light_grey },
    ["Conceal"] = { fg = "NONE", bg = "NONE", link = "NONE" },
    ["CurSearch"] = { link = "Visual" },
    ["Cursor"] = { fg = "bg", bg = "fg" },
    ["lCursor"] = { link = "Cursor" },
    ["CursorIM"] = { link = "Cursor" },
    ["CursorColumn"] = { link = "ColorColumn" },
    ["CursorLine"] = { link = "Visual" },
    ["Directory"] = { bold = true },
    ["DiffAdd"] = { fg = colors.dark_green, bg = colors.light_green },
    ["DiffChange"] = { fg = colors.dark_yellow, bg = colors.light_yellow },
    ["DiffDelete"] = { fg = colors.dark_red, bg = colors.light_red },
    ["DiffText"] = { link = "DiffChange" },
    ["EndOfBuffer"] = { fg = colors.dark_grey },
    ["TermCursor"] = { fg = "bg", bg = "fg" },
    ["ErrorMsg"] = { fg = colors.red },
    ["WinSeparator"] = {},
    ["Folded"] = { fg = colors.near_black },
    ["FoldColumn"] = { link = "Folded" },
    ["SignColumn"] = { fg = colors.dark_grey },
    ["IncSearch"] = { link = "Visual" },
    ["IncReplace"] = { link = "DiffChange" },
    ["LineNr"] = { fg = colors.near_black, bold = true },
    ["LineNrAbove"] = { fg = colors.grey },
    ["LineNrBelow"] = { link = "LineNrAbove" },
    ["MatchParen"] = { fg = colors.near_black, bold = true },
    ["ModeMsg"] = { fg = colors.near_black, bold = true },
    ["MoreMsg"] = { fg = colors.dark_grey },
    ["Normal"] = { fg = colors.near_black, bg = colors.white },
    ["NormalFloat"] = { link = "Normal" },
    ["NonText"] = { fg = colors.light_grey },
    ["FloatBorder"] = { fg = colors.near_black },
    ["FloatTitle"] = { link = "Title" },
    ["FloatFooter"] = { link = "FloatTitle" },
    ["Pmenu"] = { fg = colors.near_black, bg = colors.white },
    ["PmenuSel"] = { link = "Visual" },
    ["PmenuKind"] = { link = "Pmenu" },
    ["PmenuKindSel"] = { link = "Visual" },
    ["PmenuExtra"] = { link = "Pmenu" },
    ["PmenuExtraSel"] = { link = "Visual" },
    ["PmenuSbar"] = { link = "Pmenu" },
    ["PmenuThumb"] = { link = "Pmenu" },
    ["Question"] = { fg = colors.dark_grey },
    ["QuickFixLine"] = { link = "Visual" },
    ["qfFileName"] = { bold = false, link = "NONE" },
    ["qfLineNr"] = { bold = false, link = "NONE" },
    ["Search"] = { link = "Visual" },
    ["SnippetTabstop"] = { link = "Visual" },
    ["SpecialKey"] = { fg = colors.dark_grey },
    ["SpellBad"] = { undercurl = true },
    ["SpellCap"] = { link = "SpellBad" },
    ["SpellLocal"] = { link = "SpellBad" },
    ["SpellRare"] = { link = "SpellBad" },
    ["StatusLine"] = { fg = colors.dark_grey, bg = colors.light_grey },
    ["StatusLineNC"] = { fg = colors.dark_grey },
    ["TabLine"] = { fg = colors.near_black, bg = colors.white },
    ["TabLineFill"] = { bg = colors.dark_grey },
    ["TabLineSel"] = { link = "StatusLine" },
    ["Title"] = { bold = true },
    ["Visual"] = { bg = colors.light_blue, bold = true },
    ["Whitespace"] = { fg = colors.grey },
    ["WildMenu"] = { bg = colors.dark_grey, bold = true },
    ["WinBar"] = { fg = colors.near_black, bg = colors.white, bold = true },
    ["WinBarNC"] = { fg = colors.near_black, bg = colors.white },

    -- Syntax (:help group-name)
    ["Comment"] = { fg = colors.dark_grey },
    ["Constant"] = { fg = colors.near_black },
    ["String"] = { fg = colors.near_black },
    ["Character"] = { link = "String" },
    ["Number"] = { fg = colors.near_black },
    ["Boolean"] = { fg = colors.near_black },
    ["Float"] = { link = "Number" },
    ["Identifier"] = { link = "Constant" },
    ["Function"] = { link = "Constant" },
    ["Statement"] = { link = "Constant" },
    ["Conditional"] = { bold = true },
    ["Repeat"] = { bold = true },
    ["Label"] = { bold = true },
    ["Operator"] = { bold = true },
    ["Keyword"] = { fg = colors.near_black, bold = true },
    ["Exception"] = { bold = true },
    ["PreProc"] = { fg = colors.near_black },
    ["Include"] = { link = "PreProc" },
    ["Define"] = { link = "PreProc" },
    ["Macro"] = { link = "PreProc" },
    ["PreCondit"] = { link = "PreProc" },
    ["Type"] = { link = "PreProc" },
    ["StorageClass"] = { link = "Type" },
    ["Structure"] = { link = "Type" },
    ["Typedef"] = { link = "Type" },
    ["Special"] = { fg = colors.near_black },
    ["SpecialChar"] = { link = "Special" },
    ["Tag"] = { fg = colors.near_black },
    ["Delimiter"] = { fg = colors.near_black },
    ["SpecialComment"] = { link = "Special" },
    ["Debug"] = { fg = colors.yellow },
    ["Underlined"] = { underline = true },
    ["Ignore"] = {},
    ["Error"] = { fg = colors.red, bold = true },
    ["Todo"] = { fg = colors.yellow, bold = true },
    ["Added"] = { fg = colors.dark_yellow },
    ["Changed"] = { fg = colors.cyan },
    ["Removed"] = { fg = colors.red },

    -- Syntax from language files
    ["gitcommitSummary"] = { fg = colors.near_black, bold = true },
    ["gitcommitFirstLine"] = { link = "gitcommitSummary" },
    ["gitcommitComment"] = { link = "Comment" },
    ["gitcommitHeader"] = { fg = colors.dark_grey, bold = true },
    ["gitcommitBranch"] = { link = "gitcommitHeader" },
    ["gitcommitDiscardedType"] = { fg = colors.dark_grey, bold = false },
    ["gitcommitDiscardedFile"] = { link = "gitcommitDiscardedType" },
    ["gitcommitSelectedType"] = { link = "gitcommitDiscardedType" },
    ["gitcommitSelectedFile"] = { link = "gitcommitDiscardedType" },
    ["gitcommitUntrackedFile"] = { link = "gitcommitDiscardedType" },
    ["diffFile"] = { fg = colors.blue },
    ["diffIndexLine"] = { fg = colors.dark_grey },
    ["diffLine"] = { link = "diffIndexLine" },
    ["diffAdded"] = { link = "DiffAdd" },
    ["diffNewFile"] = { link = "DiffAdd" },
    ["diffOldFile"] = { link = "DiffChange" },
    ["diffChanged"] = { link = "DiffChange" },
    ["diffRemoved"] = { link = "DiffDelete" },
    ["mailHeader"] = { bold = false },
    ["mailHeaderKey"] = { link = "mailHeader" },
    ["mailURL"] = { underline = true },
    ["mailEmail"] = { link = "mailURL" },
    ["mailQuoted"] = { link = "Comment" },
    ["mailQuoted1"] = { link = "mailQuoted" },
    ["mailQuoted3"] = { link = "mailQuoted" },
    ["mailQuoted5"] = { link = "mailQuoted" },
    ["mailQuoted2"] = { fg = colors.blue, bg = colors.white },
    ["mailQuoted4"] = { link = "mailQuoted2" },
    ["mailQuoted6"] = { link = "mailQuoted2" },

    -- Tree-sitter (:help treesitter-highlight-groups)
    ["@variable"] = { fg = colors.near_black },
    ["@variable.builtin"] = { link = "Variable" },
    ["@variable.parameter"] = { link = "Variable" },
    ["@variable.parameter.builtin"] = { link = "Variable" },
    ["@variable.member"] = { link = "Variable" },
    ["@constant"] = { link = "Variable" },
    ["@constant.builtin"] = { link = "Variable" },
    ["@constant.macro"] = { link = "Variable" },
    ["@module"] = { fg = colors.near_black, bold = true },
    ["@module.builtin"] = { link = "@module" },
    ["@label"] = { link = "@module" },
    ["@string"] = { link = "String" },
    ["@string.documentation"] = { link = "Comment" },
    ["@string.regexp"] = { link = "String" },
    ["@string.escape"] = { link = "String" },
    ["@string.special"] = { link = "String" },
    ["@string.special.symbol"] = { link = "String" },
    ["@string.special.path"] = { link = "String" },
    ["@string.special.url"] = { link = "String" },
    ["@character"] = { link = "String" },
    ["@character.special"] = { link = "String" },
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@number.float"] = { link = "Float" },
    ["@type"] = { link = "Type" },
    ["@type.builtin"] = { link = "Type" },
    ["@type.definition"] = { link = "Type" },
    ["@attribute"] = { link = "Type" },
    ["@attribute.builtin"] = { link = "Type" },
    ["@property"] = { link = "Type" },
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Function" },
    ["@function.call"] = { link = "Function" },
    ["@function.macro"] = { link = "Function" },
    ["@function.method"] = { link = "Function" },
    ["@function.method.call"] = { link = "Function" },
    ["@constructor"] = { link = "Function" },
    ["@operator"] = { link = "Operator" },
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.coroutine"] = { link = "Keyword" },
    ["@keyword.function"] = { link = "Keyword" },
    ["@keyword.operator"] = { link = "Keyword" },
    ["@keyword.import"] = { link = "Keyword" },
    ["@keyword.type"] = { link = "Keyword" },
    ["@keyword.modifier"] = { link = "Keyword" },
    ["@keyword.repeat"] = { link = "Keyword" },
    ["@keyword.return"] = { link = "Keyword" },
    ["@keyword.debug"] = { link = "Keyword" },
    ["@keyword.exception"] = { link = "Keyword" },
    ["@keyword.conditional"] = { link = "Keyword" },
    ["@keyword.conditional.ternary"] = { link = "Keyword" },
    ["@keyword.directive"] = { link = "Keyword" },
    ["@keyword.directive.define"] = { link = "Keyword" },
    ["@punctuation.delimiter"] = { link = "Delimiter" },
    ["@punctuation.bracket"] = { link = "Delimiter" },
    ["@punctuation.special"] = { link = "Delimiter" },
    ["@comment"] = { link = "Comment" },
    ["@comment.documentation"] = { link = "Comment" },
    ["@comment.error"] = { fg = colors.dark_grey, bg = colors.yellow },
    ["@comment.warning"] = { link = "@comment.error" },
    ["@comment.todo"] = { fg = colors.dark_grey, bg = colors.light_yellow },
    ["@comment.note"] = { link = "@comment.todo" },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = colors.near_black, bold = true },
    ["@markup.heading.1"] = { link = "@markup.heading" },
    ["@markup.heading.2"] = { link = "@markup.heading" },
    ["@markup.heading.3"] = { link = "@markup.heading" },
    ["@markup.heading.4"] = { link = "@markup.heading" },
    ["@markup.heading.5"] = { link = "@markup.heading" },
    ["@markup.heading.6"] = { link = "@markup.heading" },
    ["@markup.quote"] = { link = "Comment" },
    ["@markup.math"] = { fg = colors.near_black },
    ["@markup.link"] = { underline = true },
    ["@markup.link.label"] = { link = "@markup.link" },
    ["@markup.link.url"] = { link = "@markup.link" },
    ["@markup.raw"] = { fg = colors.dark_grey },
    ["@markup.raw.block"] = { fg = colors.dark_grey },
    ["@markup.list"] = { fg = colors.near_black },
    ["@markup.list.checked"] = { link = "@markup.list" },
    ["@markup.list.unchecked"] = { link = "@markup.list" },
    ["@diff.plus"] = { link = "DiffAdd" },
    ["@diff.minus"] = { link = "DiffDelete" },
    ["@diff.delta"] = { link = "DiffChange" },
    ["@tag"] = { fg = colors.dark_grey },
    ["@tag.builtin"] = { fg = colors.dark_grey },
    ["@tag.attribute"] = { fg = colors.dark_grey },
    ["@tag.delimiter"] = { fg = colors.dark_grey },

    -- Diagnostics (:help diagnostic-highlights)
    ["DiagnosticError"] = { fg = colors.dark_red, bg = colors.light_red },
    ["DiagnosticWarn"] = { fg = colors.dark_yellow, bg = colors.light_yellow },
    ["DiagnosticInfo"] = { fg = colors.dark_green, bg = colors.light_green },
    ["DiagnosticHint"] = { fg = colors.dark_blue, bg = colors.light_blue },
    ["DiagnosticOk"] = { link = "NONE" },
    ["DiagnosticVirtualTextError"] = { link = "DiagnosticError" },
    ["DiagnosticVirtualTextWarn"] = { link = "DiagnosticWarn" },
    ["DiagnosticVirtualTextInfo"] = { link = "DiagnosticInfo" },
    ["DiagnosticVirtualTextHint"] = { link = "DiagnosticHint" },
    ["DiagnosticVirtualTextOk"] = { link = "DiagnosticOk" },
    ["DiagnosticUnderlineError"] = { link = "NONE" },
    ["DiagnosticUnderlineWarn"] = { link = "NONE" },
    ["DiagnosticUnderlineInfo"] = { link = "NONE" },
    ["DiagnosticUnderlineHint"] = { link = "NONE" },
    ["DiagnosticUnderlineOk"] = { link = "NONE" },
    ["DiagnosticFloatingError"] = { link = "DiagnosticError" },
    ["DiagnosticFloatingWarn"] = { link = "DiagnosticWarn" },
    ["DiagnosticFloatingInfo"] = { link = "DiagnosticInfo" },
    ["DiagnosticFloatingHint"] = { link = "DiagnosticHint" },
    ["DiagnosticFloatingOk"] = { link = "DiagnosticOk" },
    ["DiagnosticSignError"] = { link = "DiagnosticError" },
    ["DiagnosticSignWarn"] = { link = "DiagnosticWarn" },
    ["DiagnosticSignInfo"] = { link = "DiagnosticInfo" },
    ["DiagnosticSignHint"] = { link = "DiagnosticHint" },
    ["DiagnosticSignOk"] = { link = "DiagnosticOk" },
    ["DiagnosticDeprecated"] = { strikethrough = true, sp = colors.red },
    ["DiagnosticUnnecessary"] = { fg = colors.dark_grey },

    -- Plugins
    --
    -- indent-blankline.nvim
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    ["IblIndent"] = { fg = colors.grey },
    ["IblWhitespace"] = { link = "IblIndent" },
    ["IblScope"] = { fg = colors.near_black },

    -- oil.nvim
    -- https://github.com/stevearc/oil.nvim
    ["OilDir"] = { fg = colors.blue },

    -- Custom queries
    ["@diff.old_file"] = { link = "DiffChange" },
    ["@diff.new_file"] = { link = "DiffAdd" },
}

local highlight = vim.api.nvim_set_hl
for group, attributes in pairs(highlight_groups) do
    highlight(0, group, attributes)
end
