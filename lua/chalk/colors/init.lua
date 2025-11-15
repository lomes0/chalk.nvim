local Util = require("chalk.util")

local M = {}

---Process base palette into complete color scheme
---@param palette chalk.Palette Base color palette
---@param opts chalk.Config Configuration options
---@return chalk.ColorScheme Complete color scheme
local function process_palette(palette, opts)
	---@class ProcessedColorScheme : chalk.ColorScheme
	local c = vim.deepcopy(palette) --[[@as ProcessedColorScheme]]

	-- Add transparency constant
	c.none = "NONE"

	-- Apply transparency settings (Kanagawa-aware)
	if opts.transparent then
		c.bg_m3 = c.none
		c.bg_m2 = c.none
		c.bg_m1 = c.none
		c.bg = c.none
		c.bg_p1 = Util.blend_bg(c.bg_p1 or palette.bg_p1, 0.5)
		c.bg_p2 = Util.blend_bg(c.bg_p2 or palette.bg_p2, 0.5)
		c.bg_1 = Util.blend_bg(c.bg_1 or palette.bg_1, 0.5)
		c.bg_2 = Util.blend_bg(c.bg_2 or palette.bg_2, 0.5)
	end

	-- Generate additional colors through blending (Kanagawa-style)
	c.bg_visual = c.bg_visual or c.selection
	c.bg_search = c.bg_search or c.search
	c.bg_sidebar = c.bg_sidebar or c.bg_m2
	c.bg_float = c.bg_float or c.bg
	c.bg_popup = c.bg_popup or c.bg
	c.bg_statusline = c.bg_statusline or c.bg
	c.border = c.border or c.dragon_black6

	-- Ensure contrast for accessibility (Kanagawa maintains natural contrast)
	c.fg_light = Util.ensure_contrast(c.fg_light, c.bg_m1, 4.5)
	c.fuji_gray = Util.ensure_contrast(c.fuji_gray, c.bg_m1, 3.0)

	-- Generate semantic color variations (Kanagawa: blended diagnostics)
	c.error_dim = Util.blend_bg(c.samurai_red, 0.2)
	c.warning_dim = Util.blend_bg(c.ronin_yellow, 0.2)
	c.info_dim = Util.blend_bg(c.crystal_blue, 0.2)
	c.hint_dim = Util.blend_bg(c.wave_aqua, 0.2)
	c.success_dim = Util.blend_bg(c.spring_green, 0.2)

	-- Terminal colors (16 color palette - Kanagawa-inspired)
	c.terminal = {
		black = c.bg_m3,
		red = c.samurai_red,
		green = c.spring_green,
		yellow = c.dragon_yellow,
		blue = c.crystal_blue,
		magenta = c.dragon_violet,
		cyan = c.wave_aqua,
		white = c.fg,
		bright_black = c.fuji_gray,
		bright_red = c.dragon_red,
		bright_green = c.dragon_green,
		bright_yellow = c.ronin_yellow,
		bright_blue = c.dragon_blue,
		bright_magenta = c.spring_violet,
		bright_cyan = c.dragon_aqua,
		bright_white = c.fg_lighter,
	}

	return c
end

---Setup color scheme based on configuration
---@param opts? chalk.Config Configuration options
---@return chalk.ColorScheme Complete color scheme
function M.setup(opts)
	opts = require("chalk.config").extend(opts)

	-- Get default palette
	local palette = require("chalk.colors.default")

	if not palette then
		error("chalk.nvim: Failed to load default palette")
	end

	-- Process palette into complete color scheme
	local colors = process_palette(palette, opts)

	-- Apply user color transformations
	if opts.on_colors and type(opts.on_colors) == "function" then
		opts.on_colors(colors)
	end

	return colors
end

return M
