-- XML TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@tag.xml"] = { fg = c.purple },
		["@tag.attribute.xml"] = { fg = c.orange },
		["@tag.delimiter.xml"] = { fg = c.light_gray },
		["@string.xml"] = { fg = c.green },
	}
end

return M
