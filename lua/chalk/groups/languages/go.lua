-- Go TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup Go-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Go TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- Go specific highlights
		["@function.builtin.go"] = { fg = c.cyan },
		["@keyword.function.go"] = { fg = c.purple },
		["@keyword.import.go"] = { fg = c.purple },
		["@type.builtin.go"] = { fg = c.yellow },
		["@variable.builtin.go"] = { fg = c.purple },
	}
end

return M
