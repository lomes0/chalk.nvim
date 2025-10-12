-- Shared utilities for chalk.nvim utils modules
-- Provides common functionality to avoid duplication

local M = {}

---Access to color utility functions
---@return table ColorUtils module
function M.color_utils()
	return require("chalk.utils.shared.color_utils")
end

---Access to command and keymap utilities
---@return table CommandUtils module
function M.command_utils()
	return require("chalk.utils.shared.command_utils")
end

---Access to chalk integration utilities
---@return table ChalkIntegration module
function M.chalk_integration()
	return require("chalk.utils.shared.chalk_integration")
end

-- Export commonly used functions at top level for convenience (lazy-loaded)
function M.notify(...)
	return M.command_utils().notify(...)
end

function M.get_colors()
	return M.chalk_integration().get_colors()
end

function M.adjust_brightness(...)
	return M.color_utils().adjust_brightness(...)
end

return M
