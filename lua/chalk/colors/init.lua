local Util = require("chalk.util")

local M = {}

---@type table<string, chalk.Palette|fun(opts: chalk.Config): chalk.Palette>
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
	local colors = vim.deepcopy(palette)

	-- Add transparency constant
	colors.none = "NONE"

	-- Apply transparency settings
	if opts.transparent then
		colors.bg = colors.none
		colors.bg_dark = colors.none
		colors.bg_darker = colors.none
		-- Keep some backgrounds for contrast
		colors.bg_light = Util.blend_bg(colors.bg_light or palette.bg_light, 0.1)
		colors.bg_lighter = Util.blend_bg(colors.bg_lighter or palette.bg_lighter, 0.2)
	end

	-- Generate additional colors through blending
	colors.bg_visual = colors.bg_visual or Util.blend_bg(colors.primary, 0.1)
	colors.bg_search = colors.bg_search or Util.blend_bg(colors.warning, 0.15)
	colors.bg_sidebar = colors.bg_sidebar or Util.darken(colors.bg, 0.8)
	colors.bg_float = colors.bg_float or colors.bg_light
	colors.bg_popup = colors.bg_popup or colors.bg_light
	colors.bg_statusline = colors.bg_statusline or colors.bg_light
	colors.border = colors.border or colors.fg_darker

	-- Generate diff background colors
	colors.diff_add_bg = colors.diff_add_bg or Util.blend_bg(colors.git_add, 0.1)
	colors.diff_change_bg = colors.diff_change_bg or Util.blend_bg(colors.git_change, 0.1)
	colors.diff_delete_bg = colors.diff_delete_bg or Util.blend_bg(colors.git_delete, 0.1)
	colors.diff_text_bg = colors.diff_text_bg or Util.blend_bg(colors.git_text, 0.1)

	-- Ensure contrast for accessibility
	colors.fg = Util.ensure_contrast(colors.fg, colors.bg, 4.5)
	colors.comment = Util.ensure_contrast(colors.comment, colors.bg, 3.0)

	-- Generate semantic color variations
	colors.error_dim = Util.blend_bg(colors.error, 0.3)
	colors.warning_dim = Util.blend_bg(colors.warning, 0.3)
	colors.info_dim = Util.blend_bg(colors.info, 0.3)
	colors.hint_dim = Util.blend_bg(colors.hint, 0.3)
	colors.success_dim = Util.blend_bg(colors.success, 0.3)

	-- Terminal colors (16 color palette)
	colors.terminal = {
		black = colors.bg_darker,
		red = colors.red,
		green = colors.green,
		yellow = colors.yellow,
		blue = colors.blue,
		magenta = colors.purple,
		cyan = colors.cyan,
		white = colors.fg,
		bright_black = colors.comment,
		bright_red = Util.lighten(colors.red, 0.1),
		bright_green = Util.lighten(colors.green, 0.1),
		bright_yellow = Util.lighten(colors.yellow, 0.1),
		bright_blue = Util.lighten(colors.blue, 0.1),
		bright_magenta = Util.lighten(colors.purple, 0.1),
		bright_cyan = Util.lighten(colors.cyan, 0.1),
		bright_white = colors.fg_light,
	}

	return colors
end

---Setup color scheme based on configuration
---@param opts? chalk.Config Configuration options
---@return chalk.ColorScheme Complete color scheme
function M.setup(opts)
	opts = require("chalk.config").extend(opts)

	-- Get the appropriate variant
	local variant = opts.variant
	local palette_source = M.variants[variant]

	if not palette_source then
		vim.notify("chalk.nvim: Unknown variant '" .. variant .. "', falling back to 'default'", vim.log.levels.WARN)
		palette_source = M.variants.default
	end

	-- Get palette (either static or generated)
	local palette
	if type(palette_source) == "function" then
		palette = palette_source(opts)
	else
		palette = palette_source
	end

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
