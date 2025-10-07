-- Main entry point for chalk.nvim colorscheme
local M = {}

-- Simple module imports - assume everything works
local config = require("chalk.config")
local colors = require("chalk.colors")

-- Setup options storage
local opts = {}

-- Function to load the colorscheme
function M.load()
	-- Get current configuration
	local user_config = config.get()

	-- Generate color theme
	local theme_colors = colors.generate_theme(user_config.variant)

	-- Call user's on_colors function if provided
	if user_config.on_colors and type(user_config.on_colors) == "function" then
		user_config.on_colors(theme_colors)
	end

	-- Clear existing highlights
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	-- Set colorscheme info
	vim.g.colors_name = "chalk"
	vim.o.background = user_config.variant == "light" and "light" or "dark"

	-- Load core highlight groups
	local editor_highlights = require("chalk.groups.editor").setup(theme_colors, user_config)
	local syntax_highlights = require("chalk.groups.syntax").setup(theme_colors, user_config)

	-- Load TreeSitter highlights if enabled
	local treesitter_highlights = {}
	if user_config.integrations.treesitter then
		local ok, treesitter_module = pcall(require, "chalk.groups.treesitter")
		if ok then
			treesitter_highlights = treesitter_module.setup(theme_colors, user_config)
		end
	end

	-- Load plugin integrations
	local integration_highlights = {}
	for integration_name, enabled in pairs(user_config.integrations) do
		if enabled and integration_name ~= "treesitter" then
			local ok, integration_module = pcall(require, "chalk.groups.integrations." .. integration_name)
			if ok and integration_module.setup then
				local plugin_highlights = integration_module.setup(theme_colors, user_config)
				for group, hl in pairs(plugin_highlights) do
					integration_highlights[group] = hl
				end
			end
		end
	end

	-- Merge all highlights (simple table merge)
	local all_highlights = {}
	for group, hl in pairs(editor_highlights) do
		all_highlights[group] = hl
	end
	for group, hl in pairs(syntax_highlights) do
		all_highlights[group] = hl
	end
	for group, hl in pairs(treesitter_highlights) do
		all_highlights[group] = hl
	end
	for group, hl in pairs(integration_highlights) do
		all_highlights[group] = hl
	end

	-- Apply user custom highlights
	if user_config.custom_highlights and type(user_config.custom_highlights) == "function" then
		local custom_highlights = user_config.custom_highlights(theme_colors)
		if custom_highlights then
			for group, hl in pairs(custom_highlights) do
				all_highlights[group] = hl
			end
		end
	end

	-- Apply transparency if enabled
	if user_config.transparent then
		for group_name, hl_def in pairs(all_highlights) do
			if hl_def.bg and hl_def.bg ~= "NONE" then
				hl_def.bg = "NONE"
			end
		end
	end

	-- Call user's on_highlights function if provided
	if user_config.on_highlights and type(user_config.on_highlights) == "function" then
		user_config.on_highlights(all_highlights, theme_colors)
	end

	-- Apply highlights
	for group, definition in pairs(all_highlights) do
		vim.api.nvim_set_hl(0, group, definition)
	end

	-- Set terminal colors if enabled
	if user_config.terminal_colors then
		vim.g.terminal_color_0 = theme_colors.bg_dark or theme_colors.bg
		vim.g.terminal_color_1 = theme_colors.error
		vim.g.terminal_color_2 = theme_colors.success
		vim.g.terminal_color_3 = theme_colors.warning
		vim.g.terminal_color_4 = theme_colors.info
		vim.g.terminal_color_5 = theme_colors.keyword
		vim.g.terminal_color_6 = theme_colors.hint
		vim.g.terminal_color_7 = theme_colors.fg
		vim.g.terminal_color_8 = theme_colors.comment
		vim.g.terminal_color_9 = theme_colors.error
		vim.g.terminal_color_10 = theme_colors.success
		vim.g.terminal_color_11 = theme_colors.warning
		vim.g.terminal_color_12 = theme_colors.info
		vim.g.terminal_color_13 = theme_colors.keyword
		vim.g.terminal_color_14 = theme_colors.hint
		vim.g.terminal_color_15 = theme_colors.fg_light or theme_colors.fg
	end

	return theme_colors
end

-- Function to setup the colorscheme with configuration
function M.setup(user_opts)
	opts = user_opts or {}
	config.setup(opts)
end

-- Function to get current colors
function M.get_colors(variant)
	variant = variant or config.get().variant or "default"
	return colors.generate_theme(variant)
end

return M
