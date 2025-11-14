-- TreeSitter Context plugin highlights
-- Plugin: nvim-treesitter/nvim-treesitter-context
local M = {}

---Setup TreeSitter Context highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights TreeSitter Context highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- TreeSitter context highlights
		["TreesitterContext"] = { bg = c.bg },
		["TreesitterContextBottom"] = { bg = c.bg },
		["TreesitterContextSeparator"] = { bg = c.bg },
		["TreesitterContextLineNumber"] = { bg = c.bg, fg = "white" },
		["TreesitterContextLineNumberBottom"] = { bg = c.bg },
	}
end

return M
