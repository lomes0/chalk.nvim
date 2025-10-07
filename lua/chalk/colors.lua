local M = {}

-- Base palette - Chalk-inspired colors (warm, earthy tones on dark backgrounds)
M.palette = {
	-- Background colors (dark slate/chalkboard tones)
	bg_darker = "#0e1419", -- Deepest background
	bg_dark = "#1a1f24", -- Dark background
	bg = "#1e2328", -- Main background (chalkboard)
	bg_light = "#2a2f35", -- Light background
	bg_lighter = "#363c42", -- Lightest background

	-- Foreground colors (chalk white/cream tones)
	fg_darker = "#8a9199", -- Darkest foreground
	fg = "#c9c7cd", -- Main foreground (chalk white)
	fg_light = "#e6e4ea", -- Light foreground

	-- Primary colors (chalk blues and teals)
	primary = "#73b3e7", -- Soft chalk blue
	secondary = "#7fc8db", -- Chalk teal
	accent = "#8ed1c7", -- Mint chalk

	-- Status colors (vivid but not harsh)
	error = "#e06c75", -- Soft red chalk
	warning = "#e5c07b", -- Yellow chalk
	info = "#61afef", -- Info blue
	hint = "#56b6c2", -- Hint cyan
	success = "#98c379", -- Green chalk

	-- Semantic colors (warm, muted tones)
	purple = "#c678dd", -- Purple chalk
	blue = "#61afef", -- Blue chalk
	red = "#e06c75", -- Red chalk
	green = "#98c379", -- Green chalk
	orange = "#d19a66", -- Orange chalk
	yellow = "#e5c07b", -- Yellow chalk
	comment = "#5c6370", -- Muted comment
	cyan = "#56b6c2", -- Cyan chalk
	light_gray = "#abb2bf", -- Light punctuation

	-- Git colors
	git_add = "#98c379", -- Git add green
	git_change = "#e5c07b", -- Git change yellow
	git_delete = "#e06c75", -- Git delete red
	git_text = "#61afef", -- Git text blue

	-- Diff colors
	diff_add = "#98c379", -- Diff add
	diff_delete = "#e06c75", -- Diff delete
	diff_change = "#e5c07b", -- Diff change
	diff_text = "#61afef", -- Diff text

	-- Selection and UI colors
	selection = "#3e4451", -- Selection background
	search = "#e5c07b", -- Search highlight
	match = "#c678dd", -- Matching bracket
	cursor = "#528bff", -- Cursor blue
	cursor_line = "#2c323c", -- Cursor line
	line_number = "#4b5263", -- Line numbers
	line_number_current = "#abb2bf", -- Current line number

	-- Menu and completion colors
	menu_bg = "#21252b", -- Menu background
	menu_sel = "#2c323c", -- Menu selection
	menu_border = "#4b5263", -- Menu border

	-- Float and popup colors
	float_bg = "#21252b", -- Float background
	float_border = "#4b5263", -- Float border

	-- Diagnostic colors
	diagnostic_error = "#e06c75", -- Diagnostic error
	diagnostic_warning = "#e5c07b", -- Diagnostic warning
	diagnostic_info = "#61afef", -- Diagnostic info
	diagnostic_hint = "#56b6c2", -- Diagnostic hint
}

-- Theme variants
M.themes = {
	-- Default dark theme
	default = function(palette)
		return vim.deepcopy(palette)
	end,

	-- Light theme variant
	light = function(palette)
		local theme = vim.deepcopy(palette)

		-- Inverted backgrounds for light theme
		theme.bg_darker = "#f8f8f8"
		theme.bg_dark = "#f0f0f0"
		theme.bg = "#ffffff"
		theme.bg_light = "#f5f5f5"
		theme.bg_lighter = "#eeeeee"

		-- Darker foregrounds for light theme
		theme.fg_darker = "#666666"
		theme.fg = "#333333"
		theme.fg_light = "#1a1a1a"

		-- Adjust key colors for light background
		theme.primary = "#0066cc"
		theme.secondary = "#0088aa"
		theme.accent = "#00aa99"
		theme.error = "#cc3333"
		theme.warning = "#cc8800"
		theme.info = "#0066cc"
		theme.hint = "#0088aa"
		theme.success = "#008844"
		theme.purple = "#9933cc"
		theme.blue = "#0066cc"
		theme.red = "#cc3333"
		theme.green = "#008844"
		theme.orange = "#cc6600"
		theme.yellow = "#cc8800"
		theme.comment = "#888888"
		theme.cyan = "#0088aa"
		theme.light_gray = "#555555"
		theme.selection = "#e6f3ff"
		theme.cursor_line = "#f5f5f5"
		theme.line_number = "#cccccc"
		theme.line_number_current = "#666666"
		theme.menu_bg = "#f8f8f8"
		theme.menu_sel = "#e6f3ff"
		theme.menu_border = "#cccccc"
		theme.float_bg = "#ffffff"
		theme.float_border = "#cccccc"

		return theme
	end,

	-- OLED theme (deeper blacks)
	oled = function(palette)
		local theme = vim.deepcopy(palette)

		-- Make backgrounds even darker for OLED
		theme.bg_darker = "#000000"
		theme.bg_dark = "#0a0a0a"
		theme.bg = "#111111"
		theme.bg_light = "#1a1a1a"
		theme.bg_lighter = "#222222"
		theme.cursor_line = "#1a1a1a"
		theme.selection = "#2a2a2a"
		theme.menu_bg = "#0a0a0a"
		theme.float_bg = "#0a0a0a"

		return theme
	end,
}

-- Generate theme based on variant
function M.generate_theme(variant)
	variant = variant or "default"
	local generator = M.themes[variant]

	if not generator then
		generator = M.themes.default
	end

	local theme = generator(M.palette)

	-- Add transparency constant (following TokyoNight pattern)
	theme.none = "NONE"

	return theme
end

return M
