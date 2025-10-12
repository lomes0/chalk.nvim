-- Telescope plugin highlights for chalk.nvim
local M = {}

---Setup Telescope highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Telescope highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- Telescope window
		TelescopeNormal = { bg = c.bg_float, fg = c.fg },
		TelescopeBorder = { bg = c.bg_float, fg = c.border },
		TelescopeTitle = { fg = c.fg, bold = true },

		-- Telescope prompts
		TelescopePromptNormal = { bg = c.bg_darker },
		TelescopePromptBorder = { bg = c.bg_darker, fg = c.bg_darker },
		TelescopePromptTitle = { bg = c.red, fg = c.bg },
		TelescopePromptPrefix = { bg = c.bg_darker, fg = c.red },
		TelescopePromptCounter = { fg = c.comment },

		-- Telescope results
		TelescopeResultsNormal = { bg = c.bg_float, fg = c.fg },
		TelescopeResultsBorder = { bg = c.bg_float, fg = c.bg_float },
		TelescopeResultsTitle = { bg = c.bg_float, fg = c.fg },

		-- Telescope preview
		TelescopePreviewNormal = { bg = c.bg_dark, fg = c.fg },
		TelescopePreviewBorder = { bg = c.bg_dark, fg = c.bg_dark },
		TelescopePreviewTitle = { bg = c.green, fg = c.bg },

		-- Telescope selections
		TelescopeSelection = { bg = c.bg_light, fg = c.fg },
		TelescopeSelectionCaret = { bg = c.bg_light, fg = c.red },
		TelescopeMultiSelection = { bg = c.bg_lighter, fg = c.fg },
		TelescopeMultiIcon = { fg = c.blue },

		-- Telescope matching
		TelescopeMatching = { fg = c.blue, bold = true },

		-- Telescope directory/file types
		TelescopeResultsClass = { fg = c.yellow },
		TelescopeResultsConstant = { fg = c.orange },
		TelescopeResultsField = { fg = c.green },
		TelescopeResultsFunction = { fg = c.blue },
		TelescopeResultsMethod = { fg = c.blue },
		TelescopeResultsOperator = { fg = c.cyan },
		TelescopeResultsStruct = { fg = c.yellow },
		TelescopeResultsVariable = { fg = c.red },
		TelescopeResultsLineNr = { fg = c.orange },
		TelescopeResultsIdentifier = { fg = c.red },
		TelescopeResultsNumber = { fg = c.orange },
		TelescopeResultsComment = { fg = c.comment },
		TelescopeResultsSpecialComment = { fg = c.comment, italic = true },

		-- Telescope file browser
		TelescopeResultsDiffAdd = { fg = c.green },
		TelescopeResultsDiffChange = { fg = c.yellow },
		TelescopeResultsDiffDelete = { fg = c.red },
	}
end

return M
