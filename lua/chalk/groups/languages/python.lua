-- Python TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup Python-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Python TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- Python specific highlights
		["@attribute.python"] = { fg = c.orange },
		["@constructor.python"] = { fg = c.yellow },
		["@function.builtin.python"] = { fg = c.cyan },
		["@keyword.operator.python"] = { fg = c.purple },
		["@parameter.python"] = { fg = c.red },
		["@punctuation.special.python"] = { fg = c.purple },
		["@type.builtin.python"] = { fg = c.yellow },
		["@variable.builtin.python"] = { fg = c.purple },
	}
end

return M
