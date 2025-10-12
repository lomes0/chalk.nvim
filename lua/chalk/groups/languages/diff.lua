-- Diff TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@text.diff.add"] = { fg = c.git_add },
		["@text.diff.delete"] = { fg = c.git_delete },
	}
end

return M
