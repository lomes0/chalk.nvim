-- Git commit TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@keyword.gitcommit"] = { fg = c.purple },
		["@string.gitcommit"] = { fg = c.green },
	}
end

return M
