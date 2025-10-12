-- TOML TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@property.toml"] = { fg = c.purple },
		["@string.toml"] = { fg = c.green },
	}
end

return M
