-- Vim TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup Vim-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Vim TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- Vim specific highlights
		["@function.builtin.vim"] = { fg = c.cyan },
		["@keyword.function.vim"] = { fg = c.purple },
		["@variable.builtin.vim"] = { fg = c.red },
	}
end

return M
