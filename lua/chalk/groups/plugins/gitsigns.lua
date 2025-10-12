-- Gitsigns plugin highlights for chalk.nvim
local Util = require("chalk.util")

local M = {}

---Setup Gitsigns highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Gitsigns highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- Sign column signs
		GitSignsAdd = { fg = c.git_add },
		GitSignsChange = { fg = c.git_change },
		GitSignsDelete = { fg = c.git_delete },
		GitSignsTopdelete = { fg = c.git_delete },
		GitSignsChangedelete = { fg = c.git_change },
		GitSignsUntracked = { fg = c.git_add },

		-- Line highlights
		GitSignsAddLn = { bg = c.diff_add_bg },
		GitSignsChangeLn = { bg = c.diff_change_bg },
		GitSignsDeleteLn = { bg = c.diff_delete_bg },
		GitSignsUntrackedLn = { bg = c.diff_add_bg },

		-- Number highlights
		GitSignsAddNr = { fg = c.git_add },
		GitSignsChangeNr = { fg = c.git_change },
		GitSignsDeleteNr = { fg = c.git_delete },
		GitSignsUntrackedNr = { fg = c.git_add },

		-- Preview highlights
		GitSignsAddPreview = { bg = Util.blend_bg(c.git_add, 0.15) },
		GitSignsDeletePreview = { bg = Util.blend_bg(c.git_delete, 0.15) },

		-- Inline highlights
		GitSignsAddInline = { bg = Util.blend_bg(c.git_add, 0.2) },
		GitSignsChangeInline = { bg = Util.blend_bg(c.git_change, 0.2) },
		GitSignsDeleteInline = { bg = Util.blend_bg(c.git_delete, 0.2) },

		-- Current line blame
		GitSignsCurrentLineBlame = { fg = c.comment, italic = true },
	}
end

return M
