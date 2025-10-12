-- Ruby TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@function.builtin.ruby"] = { fg = c.cyan },
		["@keyword.function.ruby"] = { fg = c.purple },
		["@symbol.ruby"] = { fg = c.yellow },
		["@variable.builtin.ruby"] = { fg = c.purple },
	}
end

return M
