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
		["TreesitterContext"] = { bg = c.bg_p1 },
		["TreesitterContextBottom"] = { bg = c.bg_p1 },
		["TreesitterContextSeparator"] = { bg = c.bg_p1 },
		["TreesitterContextLineNumber"] = { bg = c.bg_p1, fg = "white" },
		["TreesitterContextLineNumberBottom"] = { bg = c.bg_p1 },
	}
end

return M
