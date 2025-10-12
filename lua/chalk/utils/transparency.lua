-- Transparency utilities for chalk.nvim
-- Provides functions to enable/disable/toggle transparency

local M = {}
local shared = require("chalk.utils.shared")

---Apply transparency to specific highlight groups
---This function applies the transparency overrides you requested
function M.apply_transparency()
	-- Make base UI transparent
	vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "VertSplit", { bg = "NONE" })

	-- Floating windows / popups / borders
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "PmenuSel", { bg = "NONE" })
end

---Enable transparency through colorscheme config and reload
function M.enable()
	shared.chalk_integration().reload_colorscheme({ transparent = true })
	shared.notify("Transparency enabled", vim.log.levels.INFO, "Transparency")
end

---Disable transparency through colorscheme config and reload
function M.disable()
	shared.chalk_integration().reload_colorscheme({ transparent = false })
	shared.notify("Transparency disabled", vim.log.levels.INFO, "Transparency")
end

---Toggle transparency on/off
function M.toggle()
	local current_config = shared.chalk_integration().get_current_config()
	if current_config.transparent then
		M.disable()
	else
		M.enable()
	end
end

---Apply transparency overrides without reloading entire colorscheme
---This is the lightweight version that just applies the highlight overrides
function M.apply_overrides()
	M.apply_transparency()
	vim.notify("Transparency overrides applied", vim.log.levels.INFO)
end

---Remove transparency overrides (restore backgrounds)
function M.remove_overrides()
	local Theme = require("chalk.theme")
	local Config = require("chalk.config")

	-- Get current colors without transparency
	local config = Config.get()
	local original_transparent = config.transparent
	config.transparent = false

	local colors = Theme.get_colors()

	-- Restore backgrounds
	vim.api.nvim_set_hl(0, "Normal", { fg = colors.fg, bg = colors.bg_3 })
	vim.api.nvim_set_hl(0, "NormalNC", { fg = colors.fg_darker, bg = colors.bg_3 })
	vim.api.nvim_set_hl(0, "SignColumn", { fg = colors.comment, bg = colors.bg_3 })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = colors.bg_3, bg = colors.bg_3 })
	vim.api.nvim_set_hl(0, "LineNr", { fg = colors.comment, bg = colors.bg_3 })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.bg_2 })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.fg, bold = true, bg = colors.bg_3 })
	vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.comment, bg = colors.bg_3 })
	vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.bg_1, bg = colors.bg_3 })

	-- Floating windows / popups / borders
	vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.fg, bg = colors.bg_2 })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.comment, bg = colors.bg_2 })
	vim.api.nvim_set_hl(0, "FloatTitle", { fg = colors.fg, bg = colors.bg_2, bold = true })
	vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.fg, bg = colors.bg_2 })
	vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.fg, bg = colors.bg_1, bold = true })

	-- Restore original setting
	config.transparent = original_transparent

	vim.notify("Transparency overrides removed", vim.log.levels.INFO)
end

---Setup transparency commands
function M.setup_commands()
	if not shared.command_utils().check_setup_needed("transparency") then
		return
	end

	local commands = {
		ChalkTransparencyEnable = {
			callback = M.enable,
			opts = { desc = "Enable transparency in Chalk colorscheme" },
		},
		ChalkTransparencyDisable = {
			callback = M.disable,
			opts = { desc = "Disable transparency in Chalk colorscheme" },
		},
		ChalkTransparencyToggle = {
			callback = M.toggle,
			opts = { desc = "Toggle transparency in Chalk colorscheme" },
		},
		ChalkTransparencyApply = {
			callback = M.apply_overrides,
			opts = { desc = "Apply transparency overrides without reloading colorscheme" },
		},
		ChalkTransparencyRemove = {
			callback = M.remove_overrides,
			opts = { desc = "Remove transparency overrides" },
		},
	}

	shared.command_utils().setup_commands(commands)
end

---Get current transparency status
---@return boolean Whether transparency is currently enabled
function M.is_enabled()
	local Config = require("chalk.config")
	return Config.get().transparent
end

return M
