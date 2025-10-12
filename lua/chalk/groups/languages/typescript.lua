-- TypeScript TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup TypeScript-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights TypeScript TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- TypeScript specific highlights
		["@constructor.typescript"] = { fg = c.yellow },
		["@function.method.typescript"] = { fg = c.blue },
		["@keyword.export.typescript"] = { fg = c.purple },
		["@keyword.import.typescript"] = { fg = c.purple },
		["@property.typescript"] = { fg = c.red },
		["@punctuation.bracket.typescript"] = { fg = c.light_gray },
		["@variable.builtin.typescript"] = { fg = c.purple },
	}
end

return M
