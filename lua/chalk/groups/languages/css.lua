-- CSS TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup CSS-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights CSS TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- CSS specific highlights
		["@property.css"] = { fg = c.red },
		["@string.css"] = { fg = c.green },
		["@type.css"] = { fg = c.yellow },
		["@function.css"] = { fg = c.blue },
		["@number.css"] = { fg = c.orange },
		["@keyword.css"] = { fg = c.purple },
		["@punctuation.delimiter.css"] = { fg = c.light_gray },
	}
end

return M
