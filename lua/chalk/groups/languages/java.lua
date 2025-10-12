-- Java TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@constant.java"] = { fg = c.yellow },
		["@function.builtin.java"] = { fg = c.cyan },
		["@keyword.import.java"] = { fg = c.purple },
		["@type.builtin.java"] = { fg = c.yellow },
		["@variable.builtin.java"] = { fg = c.purple },
	}
end

return M
