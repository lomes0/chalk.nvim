-- Lua TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup Lua-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Lua TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- Lua specific highlights (currently commented in main file)
		-- ["@constructor.lua"] = { fg = c.steel },
		-- ["@function.call.lua"] = { fg = c.slate_blue },
		-- ["@keyword.function.lua"] = { fg = c.lavender_mist },
		-- ["@keyword.operator.lua"] = { fg = c.slate_blue },
		-- ["@punctuation.bracket.lua"] = { fg = c.steel },
		-- ["@punctuation.delimiter.lua"] = { fg = c.stone },
		-- ["@variable.builtin.lua"] = { fg = c.rust },
	}
end

return M
