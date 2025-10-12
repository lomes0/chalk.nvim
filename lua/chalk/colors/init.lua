local Util = require("chalk.util")

local M = {}

---@type table<string, chalk.Palette>
M.variants = setmetatable({}, {
	__index = function(_, variant)
		local mod = Util.mod("chalk.colors." .. variant)
		return mod and vim.deepcopy(mod) or nil
	end,
})

---Process base palette into complete color scheme
---@param palette chalk.Palette Base color palette
---@param opts chalk.Config Configuration options
---@return chalk.ColorScheme Complete color scheme
local function process_palette(palette, opts)
	---@class ProcessedColorScheme : chalk.ColorScheme
	local c = vim.deepcopy(palette) --[[@as ProcessedColorScheme]]

	-- Add transparency constant
	c.none = "NONE"

	-- Apply transparency settings
	if opts.transparent then
		c.bg_1 = Util.blend_bg(c.bg_1 or palette.bg_1, 0.5)
		c.bg_2 = Util.blend_bg(c.bg_2 or palette.bg_2, 0.5)
		c.bg_3 = Util.blend_bg(c.bg_3 or palette.bg_2, 0.5)
		c.bg_4 = Util.blend_bg(c.bg_4 or palette.bg_2, 0.5)
	end

	-- Generate additional colors through blending
	c.bg_visual = c.bg_visual or Util.blend_bg(c.primary, 0.1)
	c.bg_search = c.bg_search or Util.blend_bg(c.warning, 0.15)
	c.bg_sidebar = c.bg_sidebar or Util.darken(c.bg_3, 0.8)
	c.bg_float = c.bg_float or c.bg_2
	c.bg_popup = c.bg_popup or c.bg_2
	c.bg_statusline = c.bg_statusline or c.bg_2
	c.border = c.border or c.fg_darker

	-- Ensure contrast for accessibility
	c.fg = Util.ensure_contrast(c.fg, c.bg_3, 4.5)
	c.comment = Util.ensure_contrast(c.comment, c.bg_3, 3.0)

	-- Generate semantic color variations
	c.error_dim = Util.blend_bg(c.error, 0.3)
	c.warning_dim = Util.blend_bg(c.warning, 0.3)
	c.info_dim = Util.blend_bg(c.info, 0.3)
	c.hint_dim = Util.blend_bg(c.hint, 0.3)
	c.success_dim = Util.blend_bg(c.success, 0.3)

	-- Terminal colors (16 color palette)
	c.terminal = {
		black = c.bg_5,
		red = c.red,
		green = c.green,
		yellow = c.yellow,
		blue = c.blue,
		magenta = c.purple,
		cyan = c.cyan,
		white = c.fg,
		bright_black = c.comment,
		bright_red = Util.lighten(c.red, 0.1),
		bright_green = Util.lighten(c.green, 0.1),
		bright_yellow = Util.lighten(c.yellow, 0.1),
		bright_blue = Util.lighten(c.blue, 0.1),
		bright_magenta = Util.lighten(c.purple, 0.1),
		bright_cyan = Util.lighten(c.cyan, 0.1),
		bright_white = c.fg_light,
	}

	return c
end

---Setup color scheme based on configuration
---@param opts? chalk.Config Configuration options
---@return chalk.ColorScheme Complete color scheme
function M.setup(opts)
	opts = require("chalk.config").extend(opts)

	-- Get the appropriate variant
	local variant = opts.variant
	local palette_source = M.variants[variant]

	-- Get palette (static)
	local palette = palette_source or M.variants.default

	if not palette then
		error("chalk.nvim: Failed to load palette for variant: " .. variant)
	end

	-- Process palette into complete color scheme
	local colors = process_palette(palette, opts)

	-- Apply user color transformations
	if opts.on_colors and type(opts.on_colors) == "function" then
		opts.on_colors(colors)
	end

	return colors
end

---Preview color scheme without applying it
---@param variant? string Variant to preview (defaults to current config)
---@return chalk.ColorScheme Color scheme for preview
function M.preview(variant)
	local opts = require("chalk.config").get()
	if variant then
		opts = vim.deepcopy(opts)
		opts.variant = variant
	end

	return M.setup(opts)
end

return M
