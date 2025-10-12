-- BufferLine plugin highlights for chalk.nvim
local M = {}

---Setup BufferLine highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights BufferLine highlight groups
function M.setup(colors, opts)
	local c = colors
	local buffer_bg = "#4a4a4a"

	return {
		-- BufferLine background and separators
		BufferLineFill = { bg = "none", fg = "none" },
		BufferLineSeparator = { bg = buffer_bg, fg = buffer_bg },
		BufferLineSeparatorSelected = { bg = buffer_bg, fg = buffer_bg },

		-- BufferLine buffer states
		BufferLineBuffer = { bg = buffer_bg, fg = "none" },
		BufferLineBufferSelected = { bg = buffer_bg, fg = "none" },
		BufferLineModifiedSelected = { bg = buffer_bg, fg = "none" },
	}
end

---Set BufferLine colors using vim.api.nvim_set_hl
---This function can be called separately for direct highlight setting
function M.set_color_bufferline()
	local buffer_bg = "#4a4a4a"
	vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "none", fg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = buffer_bg, fg = buffer_bg })
	vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = buffer_bg, fg = buffer_bg })
	vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { bg = buffer_bg, fg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineBuffer", { bg = buffer_bg, fg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = buffer_bg, fg = "none" })
end

return M
