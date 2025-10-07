-- Editor UI highlight groups for chalk.nvim
local M = {}

function M.setup(colors, config)
	local c = colors

	local highlights = {
		-- Basic UI
		Normal = { fg = c.fg, bg = c.bg },
		NormalFloat = { fg = c.fg, bg = c.bg_light },
		NormalNC = { link = "Normal" },

		-- Cursor and line
		Cursor = { fg = c.bg, bg = c.fg },
		CursorLine = { bg = c.bg_light },
		CursorColumn = { bg = c.bg_light },
		CursorLineNr = { fg = c.fg, bold = true },

		-- Line numbers
		LineNr = { fg = c.comment },
		SignColumn = { fg = c.comment, bg = c.bg },

		-- Folds
		Folded = { fg = c.comment, bg = c.bg_light, italic = true },
		FoldColumn = { fg = c.comment, bg = c.bg },

		-- Selection and search
		Visual = { bg = c.bg_lighter },
		VisualNOS = { bg = c.bg_lighter },
		Search = { fg = c.bg, bg = c.warning },
		IncSearch = { fg = c.bg, bg = c.warning, bold = true },
		CurSearch = { fg = c.bg, bg = c.warning, bold = true },

		-- Messages and command line
		MsgArea = { fg = c.fg },
		MsgSeparator = { fg = c.comment },
		MoreMsg = { fg = c.success, bold = true },
		Question = { fg = c.info, bold = true },
		WarningMsg = { fg = c.warning, bold = true },
		ErrorMsg = { fg = c.error, bold = true },

		-- Status line
		StatusLine = { fg = c.fg, bg = c.bg_light },
		StatusLineNC = { fg = c.comment, bg = c.bg_dark },

		-- Tab line
		TabLine = { fg = c.comment, bg = c.bg_dark },
		TabLineFill = { bg = c.bg_dark },
		TabLineSel = { fg = c.fg, bg = c.bg, bold = true },

		-- Windows and splits
		WinBar = { fg = c.fg_light, bg = c.bg },
		WinBarNC = { fg = c.comment, bg = c.bg },
		WinSeparator = { fg = c.bg_lighter },
		VertSplit = { fg = c.bg_lighter }, -- Legacy

		-- Popup menus
		Pmenu = { fg = c.fg, bg = c.bg_light },
		PmenuSel = { fg = c.fg, bg = c.bg_lighter, bold = true },
		PmenuSbar = { bg = c.bg_lighter },
		PmenuThumb = { bg = c.fg },

		-- Wild menu
		WildMenu = { fg = c.fg, bg = c.bg_lighter, bold = true },

		-- Floating windows
		FloatBorder = { fg = c.bg_lighter, bg = c.bg_light },
		FloatTitle = { fg = c.fg, bg = c.bg_light, bold = true },

		-- Columns and guides
		ColorColumn = { bg = c.bg_light },
		Conceal = { fg = c.comment },

		-- Diff
		DiffAdd = { fg = c.success, bg = c.bg_light },
		DiffChange = { fg = c.warning, bg = c.bg_light },
		DiffDelete = { fg = c.error, bg = c.bg_light },
		DiffText = { fg = c.info, bg = c.bg_light, bold = true },

		-- Spelling
		SpellBad = { fg = c.error, undercurl = true, sp = c.error },
		SpellCap = { fg = c.warning, undercurl = true, sp = c.warning },
		SpellLocal = { fg = c.info, undercurl = true, sp = c.info },
		SpellRare = { fg = c.hint, undercurl = true, sp = c.hint },

		-- Diagnostics
		DiagnosticError = { fg = c.error },
		DiagnosticWarn = { fg = c.warning },
		DiagnosticInfo = { fg = c.info },
		DiagnosticHint = { fg = c.hint },
		DiagnosticOk = { fg = c.success },

		-- Diagnostic virtual text
		DiagnosticVirtualTextError = { fg = c.error, bg = c.bg_light },
		DiagnosticVirtualTextWarn = { fg = c.warning, bg = c.bg_light },
		DiagnosticVirtualTextInfo = { fg = c.info, bg = c.bg_light },
		DiagnosticVirtualTextHint = { fg = c.hint, bg = c.bg_light },
		DiagnosticVirtualTextOk = { fg = c.success, bg = c.bg_light },

		-- Diagnostic underlines
		DiagnosticUnderlineError = { undercurl = true, sp = c.error },
		DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning },
		DiagnosticUnderlineInfo = { undercurl = true, sp = c.info },
		DiagnosticUnderlineHint = { undercurl = true, sp = c.hint },
		DiagnosticUnderlineOk = { undercurl = true, sp = c.success },

		-- Diagnostic signs
		DiagnosticSignError = { fg = c.error, bg = c.bg },
		DiagnosticSignWarn = { fg = c.warning, bg = c.bg },
		DiagnosticSignInfo = { fg = c.info, bg = c.bg },
		DiagnosticSignHint = { fg = c.hint, bg = c.bg },
		DiagnosticSignOk = { fg = c.success, bg = c.bg },

		-- Directory
		Directory = { fg = c.info, bold = true },

		-- Special keys
		SpecialKey = { fg = c.comment },
		NonText = { fg = c.comment },
		Whitespace = { fg = c.comment },

		-- Match and parentheses
		MatchParen = { fg = c.secondary, bold = true, underline = true },

		-- Title
		Title = { fg = c.primary, bold = true },

		-- Health check
		healthError = { fg = c.error },
		healthSuccess = { fg = c.success },
		healthWarning = { fg = c.warning },

		-- Terminal
		TermCursor = { fg = c.bg, bg = c.fg },
		TermCursorNC = { fg = c.bg, bg = c.fg },

		-- Quickfix
		QuickFixLine = { bg = c.bg_lighter, bold = true },

		-- Substitute
		Substitute = { fg = c.bg, bg = c.secondary, bold = true },

		-- Modes
		ModeMsg = { fg = c.fg_light, bold = true },

		-- End of buffer
		EndOfBuffer = { fg = c.bg },
	}

	return highlights
end

return M

