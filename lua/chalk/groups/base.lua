-- Base highlight groups for chalk.nvim
-- Combines editor UI and syntax highlighting
local M = {}

---Setup base highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Highlight groups
function M.setup(colors, opts)
	local c = colors

	local highlights = {
		-- Editor colors (Kanagawa-inspired backgrounds)
		Normal = { fg = c.fg_light, bg = c.bg_m1 },
		NormalFloat = { fg = c.fg_light, bg = c.bg_m1 },
		NormalNC = { fg = c.fg_dim, bg = c.bg_m1 },

		-- Cursor (Kanagawa: clear contrast)
		Cursor = { fg = c.bg_m1, bg = c.cursor },
		CursorLine = { bg = c.cursor_line },
		CursorColumn = { bg = c.bg },
		CursorLineNr = { fg = c.line_number_current, bold = true, bg = c.bg },

		-- Line numbers (Kanagawa: muted but visible)
		LineNr = { fg = c.line_number, bg = c.bg_m1 },
		SignColumn = { fg = c.line_number, bg = c.bg_m1 },

		-- Folds (Kanagawa: subtle with comment color)
		Folded = { fg = c.fuji_gray, bg = c.bg, italic = true },
		FoldColumn = { fg = c.fuji_gray, bg = c.bg },

		-- Selection and search (Kanagawa: muted backgrounds)
		Visual = { bg = c.selection },
		VisualNOS = { bg = c.selection },
		Search = { bg = c.search },
		IncSearch = { fg = c.fg_light, bg = c.search, bold = true },
		CurSearch = { fg = c.fg_light, bg = c.search, bold = true },

		-- Messages and command line (Kanagawa semantic colors)
		MsgArea = { fg = c.fg_light },
		MsgSeparator = { fg = c.border },
		MoreMsg = { fg = c.spring_green, bold = true },
		Question = { fg = c.crystal_blue, bold = true },
		WarningMsg = { fg = c.ronin_yellow, bold = true },
		ErrorMsg = { fg = c.samurai_red, bold = true },

		-- Status line (Kanagawa: subtle backgrounds)
		StatusLine = { fg = c.fg_light, bg = c.bg },
		StatusLineNC = { fg = c.fuji_gray, bg = c.bg_m2 },

		-- Tab line (Kanagawa: muted progression)
		TabLine = { fg = c.fuji_gray, bg = c.bg_m2 },
		TabLineFill = { bg = c.bg_m3 },
		TabLineSel = { fg = c.fg_light, bg = c.bg, bold = true },

		-- Windows and splits (Kanagawa: subtle borders)
		WinBar = { fg = c.fg_light, bg = c.bg },
		WinBarNC = { fg = c.fuji_gray, bg = c.bg_m2 },
		WinSeparator = { fg = c.border },
		VertSplit = { fg = c.border }, -- Legacy

		-- Popup menus (Kanagawa: floating UI)
		Pmenu = { fg = c.fg_light, bg = c.bg },
		PmenuSel = { fg = c.bg_m1, bg = c.crystal_blue, bold = true },
		PmenuSbar = { bg = c.bg_p1 },
		PmenuThumb = { bg = c.border },

		-- Wild menu
		WildMenu = { fg = c.bg_m1, bg = c.crystal_blue, bold = true },

		-- Floating windows (Kanagawa: consistent float style)
		FloatBorder = { fg = c.border, bg = c.bg },
		FloatTitle = { fg = c.fg_light, bg = c.bg, bold = true },

		-- Columns and guides
		ColorColumn = { bg = c.bg },
		Conceal = { fg = c.fuji_gray },

		-- Diff (Kanagawa: muted git colors)
		DiffDelete = { bg = c.none, fg = c.dragon_red },
		DiffAdd = { bg = c.none },
		DiffChange = { bg = c.none },
		DiffText = { bg = c.diff_text_bg },

		-- Spelling (Kanagawa semantic colors)
		SpellBad = { fg = c.samurai_red, undercurl = true, sp = c.samurai_red },
		SpellCap = { fg = c.ronin_yellow, undercurl = true, sp = c.ronin_yellow },
		SpellLocal = { fg = c.crystal_blue, undercurl = true, sp = c.crystal_blue },
		SpellRare = { fg = c.wave_aqua, undercurl = true, sp = c.wave_aqua },

		-- Diagnostics (Kanagawa diagnostic system)
		DiagnosticError = { fg = c.samurai_red },
		DiagnosticWarn = { fg = c.ronin_yellow },
		DiagnosticInfo = { fg = c.crystal_blue },
		DiagnosticHint = { fg = c.wave_aqua },
		DiagnosticOk = { fg = c.spring_green },

		-- Diagnostic virtual text (Kanagawa: muted diagnostics)
		DiagnosticVirtualTextError = { fg = c.diagnostic_error, bg = c.bg },
		DiagnosticVirtualTextWarn = { fg = c.diagnostic_warning, bg = c.bg },
		DiagnosticVirtualTextInfo = { fg = c.diagnostic_info, bg = c.bg },
		DiagnosticVirtualTextHint = { fg = c.diagnostic_hint, bg = c.bg },
		DiagnosticVirtualTextOk = { fg = c.spring_green, bg = c.bg },

		-- Diagnostic underlines (Kanagawa: bright semantic colors)
		DiagnosticUnderlineError = { undercurl = true, sp = c.samurai_red },
		DiagnosticUnderlineWarn = { undercurl = true, sp = c.ronin_yellow },
		DiagnosticUnderlineInfo = { undercurl = true, sp = c.crystal_blue },
		DiagnosticUnderlineHint = { undercurl = true, sp = c.wave_aqua },
		DiagnosticUnderlineOk = { undercurl = true, sp = c.spring_green },

		-- Diagnostic signs (Kanagawa: bright for visibility)
		DiagnosticSignError = { fg = c.samurai_red, bg = c.bg },
		DiagnosticSignWarn = { fg = c.ronin_yellow, bg = c.bg },
		DiagnosticSignHint = { fg = c.wave_aqua, bg = c.bg },
		DiagnosticSignOk = { fg = c.spring_green, bg = c.bg },
		DiagnosticSignInfo = { fg = c.crystal_blue, bg = c.bg },

		-- Directory
		Directory = { fg = c.crystal_blue, bold = true },

		-- Special keys (Kanagawa: subtle grays)
		SpecialKey = { fg = c.fuji_gray },
		NonText = { fg = c.fuji_gray },
		Whitespace = { fg = c.line_number },

		-- Match and parentheses (Kanagawa: accent highlight)
		MatchParen = { fg = c.dragon_orange, bold = true, underline = true },

		-- Title (Kanagawa: prominent foreground)
		Title = { fg = c.crystal_blue, bold = true },

		-- Health check
		healthError = { fg = c.samurai_red },
		healthSuccess = { fg = c.spring_green },
		healthWarning = { fg = c.ronin_yellow },

		-- Terminal
		TermCursor = { fg = c.bg_m1, bg = c.cursor },
		TermCursorNC = { fg = c.bg_m1, bg = c.fg_dim },

		-- Quickfix
		QuickFixLine = { bg = c.bg, bold = true },

		-- Substitute (Kanagawa: accent highlight)
		Substitute = { fg = c.bg_m1, bg = c.dragon_orange, bold = true },

		-- Modes
		ModeMsg = { fg = c.fg_light, bold = true },

		-- End of buffer
		EndOfBuffer = { fg = c.bg_m1 },

		-- === SYNTAX HIGHLIGHTING (Kanagawa-inspired) ===

		-- Comments (Kanagawa: fujiGray - muted natural)
		Comment = { fg = c.fuji_gray, italic = opts.styles.comments and opts.styles.comments.italic },

		-- Constants (Kanagawa: pink/violet for constants)
		Constant = {
			fg = c.dragon_pink,
			italic = opts.styles.constants and opts.styles.constants.italic,
			bold = opts.styles.constants and opts.styles.constants.bold,
		},
		String = { fg = c.spring_green, italic = opts.styles.strings and opts.styles.strings.italic },
		Character = { fg = c.spring_green },
		Number = { fg = c.sakura_pink },
		Boolean = { fg = c.dragon_pink },
		Float = { fg = c.sakura_pink },

		-- Identifiers (Kanagawa: coral/red for variables)
		Identifier = { fg = c.fg_light, italic = opts.styles.variables and opts.styles.variables.italic },
		Function = {
			fg = c.crystal_blue,
			italic = opts.styles.functions and opts.styles.functions.italic,
			bold = opts.styles.functions and opts.styles.functions.bold,
		},

		-- Statements (Kanagawa: violet for keywords)
		Statement = {
			fg = c.dragon_violet,
			italic = opts.styles.keywords and opts.styles.keywords.italic,
			bold = opts.styles.keywords and opts.styles.keywords.bold,
		},
		Conditional = { fg = c.dragon_violet },
		Repeat = { fg = c.dragon_violet },
		Label = { fg = c.dragon_pink },
		Operator = {
			fg = c.dragon_violet,
			italic = opts.styles.operators and opts.styles.operators.italic,
			bold = opts.styles.operators and opts.styles.operators.bold,
		},
		Keyword = {
			fg = c.dragon_violet,
			italic = opts.styles.keywords and opts.styles.keywords.italic,
			bold = opts.styles.keywords and opts.styles.keywords.bold,
		},
		Exception = { fg = c.dragon_red },

		-- PreProcessor (Kanagawa: pink/yellow for macros)
		PreProc = { fg = c.dragon_pink },
		Include = { fg = c.dragon_pink },
		Define = { fg = c.dragon_pink },
		Macro = { fg = c.dragon_violet },
		PreCondit = { fg = c.dragon_yellow },

		-- Types (Kanagawa: aqua/teal for definitions)
		Type = {
			fg = c.dragon_aqua,
			italic = opts.styles.types and opts.styles.types.italic,
			bold = opts.styles.types and opts.styles.types.bold,
		},
		StorageClass = { fg = c.dragon_violet },
		Structure = { fg = c.dragon_aqua },
		Typedef = { fg = c.dragon_aqua },

		-- Special (Kanagawa: various accents)
		Special = { fg = c.dragon_red },
		SpecialChar = { fg = c.dragon_red, bold = true },
		Tag = { fg = c.dragon_pink },
		Delimiter = { fg = c.fg_dim },
		SpecialComment = { fg = c.fuji_gray, bold = true },
		Debug = { fg = c.samurai_red },

		-- Underlined
		Underlined = { underline = true },

		-- Ignore
		Ignore = { fg = c.bg },

		-- Error
		Error = { fg = c.samurai_red, bold = true },

		-- Todo
		Todo = { fg = c.dragon_violet, bg = c.bg_p1, bold = true },
	}

	return highlights
end

return M
