-- YAML TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		["@field.yaml"] = { fg = c.purple },
		["@string.yaml"] = { fg = c.green },
		["@number.yaml"] = { fg = c.orange },
		["@boolean.yaml"] = { fg = c.orange },
		["@constant.yaml"] = { fg = c.yellow },
		["@punctuation.delimiter.yaml"] = { fg = c.light_gray },
	}
end

return M
