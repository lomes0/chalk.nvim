-- JSON TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@label.json"] = { fg = c.purple },
		["@string.json"] = { fg = c.dim_green },
		["@number.json"] = { fg = c.orange },
		["@boolean.json"] = { fg = c.orange },
		["@constant.json"] = { fg = c.yellow },
	}
end

return M
