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
		["TreesitterContext"] = { bg = c.bg, italic = true },
		["TreesitterContextBottom"] = { bg = c.bg, italic = true },
		["TreesitterContextSeparator"] = { bg = c.bg, italic = true },
		["TreesitterContextLineNumber"] = { bg = c.bg, italic = true, fg = "white" },
		["TreesitterContextLineNumberBottom"] = { bg = c.bg, italic = true },
	}
end

return M
