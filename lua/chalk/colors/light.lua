-- Light theme variant for chalk.nvim
-- Chalk colors adapted for light backgrounds

---@type chalk.Palette
return {
	-- Background colors (light paper/whiteboard tones)
	bg_darker = "#f8f8f8", -- Lightest background
	bg_dark = "#f0f0f0", -- Light background
	bg = "#ffffff", -- Main background (paper white)
	bg_light = "#f5f5f5", -- Slightly darker background
	bg_lighter = "#eeeeee", -- Darker background

	-- Foreground colors (dark text tones)
	fg_darker = "#666666", -- Darkest foreground
	fg = "#333333", -- Main foreground (dark text)
	fg_light = "#1a1a1a", -- Darkest foreground

	-- Primary colors (darker blues and teals for contrast)
	primary = "#0066cc", -- Deep blue
	secondary = "#0088aa", -- Deep teal
	accent = "#00aa99", -- Deep mint

	-- Status colors (darker for light background)
	error = "#cc3333", -- Deep red
	warning = "#cc8800", -- Deep yellow/orange
	info = "#0066cc", -- Deep blue
	hint = "#0088aa", -- Deep cyan
	success = "#008844", -- Deep green

	-- Semantic colors (darker versions)
	purple = "#9933cc", -- Deep purple
	blue = "#0066cc", -- Deep blue
	red = "#cc3333", -- Deep red
	green = "#008844", -- Deep green
	orange = "#cc6600", -- Deep orange
	yellow = "#cc8800", -- Deep yellow
	comment = "#888888", -- Medium gray comment
	cyan = "#0088aa", -- Deep cyan
	light_gray = "#555555", -- Dark gray punctuation

	-- Git colors (darker for contrast)
	git_add = "#008844", -- Git add deep green
	git_change = "#cc8800", -- Git change deep yellow
	git_delete = "#cc3333", -- Git delete deep red
	git_text = "#0066cc", -- Git text deep blue

	-- Diff colors (darker)
	diff_add = "#008844", -- Diff add
	diff_delete = "#cc3333", -- Diff delete
	diff_change = "#cc8800", -- Diff change
	diff_text = "#0066cc", -- Diff text

	-- Selection and UI colors (light tones)
	selection = "#e6f3ff", -- Light blue selection
	search = "#fff3cd", -- Light yellow search highlight
	match = "#f3e6ff", -- Light purple matching bracket
	cursor = "#0066cc", -- Deep blue cursor
	cursor_line = "#f5f5f5", -- Very light gray cursor line
	line_number = "#cccccc", -- Light gray line numbers
	line_number_current = "#666666", -- Medium gray current line number

	-- Menu and completion colors (light tones)
	menu_bg = "#f8f8f8", -- Light gray menu background
	menu_sel = "#e6f3ff", -- Light blue menu selection
	menu_border = "#cccccc", -- Light gray menu border

	-- Float and popup colors (light tones)
	float_bg = "#ffffff", -- White float background
	float_border = "#cccccc", -- Light gray float border

	-- Diagnostic colors (darker for contrast)
	diagnostic_error = "#cc3333", -- Deep red diagnostic error
	diagnostic_warning = "#cc8800", -- Deep yellow diagnostic warning
	diagnostic_info = "#0066cc", -- Deep blue diagnostic info
	diagnostic_hint = "#0088aa", -- Deep cyan diagnostic hint
}
