-- Dockerfile TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@keyword.dockerfile"] = { fg = c.purple },
		["@string.dockerfile"] = { fg = c.green },
	}
end

return M
