-- PHP TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@function.builtin.php"] = { fg = c.cyan },
		["@keyword.operator.php"] = { fg = c.purple },
		["@variable.builtin.php"] = { fg = c.red },
	}
end

return M
