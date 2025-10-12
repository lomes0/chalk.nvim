-- JavaScript/TypeScript TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup JavaScript/TypeScript-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights JavaScript/TypeScript TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- JavaScript specific highlights
		["@constructor.javascript"] = { fg = c.yellow },
		["@function.method.javascript"] = { fg = c.blue },
		["@keyword.export.javascript"] = { fg = c.purple },
		["@keyword.import.javascript"] = { fg = c.purple },
		["@property.javascript"] = { fg = c.red },
		["@punctuation.bracket.javascript"] = { fg = c.light_gray },
		["@variable.builtin.javascript"] = { fg = c.purple },
	}
end

return M
