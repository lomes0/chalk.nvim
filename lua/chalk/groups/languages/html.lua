-- HTML TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@tag.html"] = { fg = c.purple },
		["@tag.attribute.html"] = { fg = c.orange },
		["@tag.delimiter.html"] = { fg = c.light_gray },
		["@string.html"] = { fg = c.green },
	}
end

return M
