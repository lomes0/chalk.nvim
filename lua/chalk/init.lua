-- Main entry point for chalk.nvim colorscheme

local Config = require("chalk.config")

local M = {}

---Load chalk colorscheme with specified options
---@param opts? chalk.Config Configuration options
---@return chalk.ColorScheme, chalk.Highlights, chalk.Config
function M.load(opts)
	opts = Config.extend(opts)

	-- Load theme through orchestrator
	return require("chalk.theme").setup(opts)
end

---Setup chalk colorscheme configuration
---@param opts? chalk.Config Configuration options
function M.setup(opts)
	Config.setup(opts)
end

---Get current colors
---@return chalk.ColorScheme Color scheme
function M.get_colors()
	return require("chalk.theme").get_colors()
end

---Toggle transparency on and off
---@return chalk.ColorScheme, chalk.Highlights, chalk.Config
function M.toggle()
	return require("chalk.theme").toggle()
end

---Get theme information and status
---@return table Theme metadata
function M.info()
	return require("chalk.theme").info()
end

-- ---Access to chalk dynamic color utilities (dynamic adjustment, transparency, etc.)
-- ---@return table Dynamic module
-- function M.dynamic()
-- 	return require("chalk.dynamic")
-- end

return M
