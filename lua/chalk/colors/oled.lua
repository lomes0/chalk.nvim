-- OLED theme variant for chalk.nvim
-- Ultra-dark backgrounds for OLED displays with true blacks

---@type chalk.Palette
return {
	-- Background colors (true blacks and deep grays for OLED)
	bg_darker = "#000000", -- Pure black
	bg_dark = "#0a0a0a", -- Nearly black
	bg = "#111111", -- Dark charcoal
	bg_light = "#1a1a1a", -- Lighter charcoal
	bg_lighter = "#222222", -- Medium gray

	-- Foreground colors (bright chalk whites for contrast)
	fg_darker = "#8a9199", -- Muted foreground
	fg = "#e0e0e0", -- Bright chalk white (increased for OLED contrast)
	fg_light = "#f0f0f0", -- Very bright foreground

	-- Primary colors (vivid but not harsh for OLED)
	primary = "#80c7ff", -- Bright chalk blue
	secondary = "#89d4e8", -- Bright chalk teal
	accent = "#9ae8d9", -- Bright mint chalk

	-- Status colors (slightly more vivid for OLED)
	error = "#ff7a85", -- Bright red chalk
	warning = "#ffd085", -- Bright yellow chalk
	info = "#80c7ff", -- Bright info blue
	hint = "#70c5d0", -- Bright hint cyan
	success = "#a8d895", -- Bright green chalk

	-- Semantic colors (enhanced for OLED contrast)
	purple = "#d898f0", -- Bright purple chalk
	blue = "#80c7ff", -- Bright blue chalk
	red = "#ff7a85", -- Bright red chalk
	green = "#a8d895", -- Bright green chalk
	orange = "#e8b580", -- Bright orange chalk
	yellow = "#ffd085", -- Bright yellow chalk
	comment = "#666666", -- Medium gray comment (not too bright)
	cyan = "#70c5d0", -- Bright cyan chalk
	light_gray = "#b8b8b8", -- Bright gray punctuation

	-- Git colors (vivid for OLED)
	git_add = "#a8d895", -- Bright git add green
	git_change = "#ffd085", -- Bright git change yellow
	git_delete = "#ff7a85", -- Bright git delete red
	git_text = "#80c7ff", -- Bright git text blue

	-- Diff colors (vivid)
	diff_add = "#a8d895", -- Bright diff add
	diff_delete = "#ff7a85", -- Bright diff delete
	diff_change = "#ffd085", -- Bright diff change
	diff_text = "#80c7ff", -- Bright diff text

	-- Selection and UI colors (dark with subtle highlights)
	selection = "#2a2a2a", -- Dark selection
	search = "#3d3d00", -- Dark yellow search highlight
	match = "#3d2a3d", -- Dark purple matching bracket
	cursor = "#70b8ff", -- Bright cursor
	cursor_line = "#1a1a1a", -- Very dark cursor line
	line_number = "#444444", -- Dark gray line numbers
	line_number_current = "#888888", -- Medium gray current line number

	-- Menu and completion colors (dark with contrast)
	menu_bg = "#0a0a0a", -- Nearly black menu background
	menu_sel = "#2a2a2a", -- Dark selection
	menu_border = "#333333", -- Dark gray border

	-- Float and popup colors (dark with contrast)
	float_bg = "#0a0a0a", -- Nearly black float background
	float_border = "#333333", -- Dark gray float border

	-- Diagnostic colors (vivid for OLED contrast)
	diagnostic_error = "#ff7a85", -- Bright red diagnostic error
	diagnostic_warning = "#ffd085", -- Bright yellow diagnostic warning
	diagnostic_info = "#80c7ff", -- Bright blue diagnostic info
	diagnostic_hint = "#70c5d0", -- Bright cyan diagnostic hint
}
