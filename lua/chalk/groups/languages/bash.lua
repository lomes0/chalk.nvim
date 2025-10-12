-- Bash/Shell TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@function.builtin.bash"] = { fg = c.cyan },
		["@keyword.function.bash"] = { fg = c.purple },
		["@parameter.bash"] = { fg = c.red },
		["@punctuation.special.bash"] = { fg = c.cyan },
		["@variable.builtin.bash"] = { fg = c.red },
	}
end

return M
