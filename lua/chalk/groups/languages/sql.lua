-- SQL TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@function.builtin.sql"] = { fg = c.cyan },
		["@keyword.sql"] = { fg = c.purple },
		["@type.builtin.sql"] = { fg = c.yellow },
	}
end

return M
