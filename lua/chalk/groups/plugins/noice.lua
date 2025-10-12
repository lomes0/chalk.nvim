-- Noice plugin highlights for chalk.nvim
local M = {}

---Get base noice highlight groups
---@param colors chalk.ColorScheme Color scheme
---@return chalk.Highlights Base noice highlight groups
local function get_base_highlights(colors)
	local c = colors

	return {
		-- Cmdline popup highlights
		NoiceCmdline = { fg = c.fg, bg = c.bg_float },
		NoiceCmdlineIcon = { fg = c.blue },
		NoiceCmdlineIconCmdline = { fg = c.cyan },
		NoiceCmdlineIconFilter = { fg = c.yellow },
		NoiceCmdlineIconHelp = { fg = c.green },
		NoiceCmdlineIconIncRename = { fg = c.orange },
		NoiceCmdlineIconInput = { fg = c.purple },
		NoiceCmdlineIconLua = { fg = c.blue },
		NoiceCmdlineIconSearch = { fg = c.yellow },
		NoiceCmdlineIconSubstitute = { fg = c.red },

		-- Cmdline popup borders and titles
		NoiceCmdlinePopup = { fg = c.fg, bg = c.bg_float },
		NoiceCmdlinePopupBorder = { fg = c.border, bg = c.bg_float },
		NoiceCmdlinePopupBorderCmdline = { fg = c.cyan, bg = c.bg_float },
		NoiceCmdlinePopupBorderFilter = { fg = c.yellow, bg = c.bg_float },
		NoiceCmdlinePopupBorderHelp = { fg = c.green, bg = c.bg_float },
		NoiceCmdlinePopupBorderIncRename = { fg = c.orange, bg = c.bg_float },
		NoiceCmdlinePopupBorderInput = { fg = c.purple, bg = c.bg_float },
		NoiceCmdlinePopupBorderLua = { fg = c.blue, bg = c.bg_float },
		NoiceCmdlinePopupBorderSearch = { fg = c.yellow, bg = c.bg_float },
		NoiceCmdlinePopupBorderSubstitute = { fg = c.red, bg = c.bg_float },

		NoiceCmdlinePopupTitle = { fg = c.fg, bg = c.bg_float, bold = true },
		NoiceCmdlinePopupTitleCmdline = { fg = c.cyan, bg = c.bg_float, bold = true },
		NoiceCmdlinePopupTitleFilter = { fg = c.yellow, bg = c.bg_float, bold = true },
		NoiceCmdlinePopupTitleHelp = { fg = c.green, bg = c.bg_float, bold = true },
		NoiceCmdlinePopupTitleIncRename = { fg = c.orange, bg = c.bg_float, bold = true },
		NoiceCmdlinePopupTitleInput = { fg = c.purple, bg = c.bg_float, bold = true },
		NoiceCmdlinePopupTitleLua = { fg = c.blue, bg = c.bg_float, bold = true },
		NoiceCmdlinePopupTitleSearch = { fg = c.yellow, bg = c.bg_float, bold = true },
		NoiceCmdlinePopupTitleSubstitute = { fg = c.red, bg = c.bg_float, bold = true },

		-- Cmdline prompt
		NoiceCmdlinePrompt = { fg = c.blue, bold = true },

		-- Completion menu
		NoiceCompletionItemMenu = { fg = c.comment, italic = true },
		NoiceCompletionItemWord = { fg = c.fg },
		NoiceCompletionItemKindDefault = { fg = c.fg, bg = c.none },

		-- Completion item kinds
		NoiceCompletionItemKindClass = { fg = c.orange },
		NoiceCompletionItemKindColor = { fg = c.green },
		NoiceCompletionItemKindConstant = { fg = c.orange },
		NoiceCompletionItemKindConstructor = { fg = c.blue },
		NoiceCompletionItemKindEnum = { fg = c.orange },
		NoiceCompletionItemKindEnumMember = { fg = c.green },
		NoiceCompletionItemKindEvent = { fg = c.red },
		NoiceCompletionItemKindField = { fg = c.green },
		NoiceCompletionItemKindFile = { fg = c.blue },
		NoiceCompletionItemKindFolder = { fg = c.blue },
		NoiceCompletionItemKindFunction = { fg = c.blue },
		NoiceCompletionItemKindInterface = { fg = c.orange },
		NoiceCompletionItemKindKeyword = { fg = c.purple },
		NoiceCompletionItemKindMethod = { fg = c.blue },
		NoiceCompletionItemKindModule = { fg = c.yellow },
		NoiceCompletionItemKindOperator = { fg = c.cyan },
		NoiceCompletionItemKindProperty = { fg = c.green },
		NoiceCompletionItemKindReference = { fg = c.red },
		NoiceCompletionItemKindSnippet = { fg = c.yellow },
		NoiceCompletionItemKindStruct = { fg = c.orange },
		NoiceCompletionItemKindText = { fg = c.fg },
		NoiceCompletionItemKindTypeParameter = { fg = c.green },
		NoiceCompletionItemKindUnit = { fg = c.orange },
		NoiceCompletionItemKindValue = { fg = c.orange },
		NoiceCompletionItemKindVariable = { fg = c.red },

		-- Confirm dialog
		NoiceConfirm = { fg = c.fg, bg = c.bg_float },
		NoiceConfirmBorder = { fg = c.border, bg = c.bg_float },

		-- Mini view (bottom right notifications)
		NoiceMini = { fg = c.fg, bg = c.bg_float },

		-- Popup view
		NoicePopup = { fg = c.fg, bg = c.bg_float },
		NoicePopupBorder = { fg = c.border, bg = c.bg_float },

		-- Split view
		NoiceSplit = { fg = c.fg, bg = c.bg_4 },
		NoiceSplitBorder = { fg = c.border, bg = c.bg_4 },

		-- Virtual text (for search count, etc.)
		NoiceVirtualText = { fg = c.comment, italic = true },

		-- Format-specific highlights
		NoiceFormatConfirm = { fg = c.green, bold = true },
		NoiceFormatConfirmDefault = { fg = c.yellow, bold = true },
		NoiceFormatDate = { fg = c.comment },
		NoiceFormatEvent = { fg = c.blue },
		NoiceFormatKind = { fg = c.purple },
		NoiceFormatLevel = { fg = c.cyan },
		NoiceFormatLevelDebug = { fg = c.comment },
		NoiceFormatLevelError = { fg = c.error },
		NoiceFormatLevelInfo = { fg = c.info },
		NoiceFormatLevelOff = { fg = c.comment },
		NoiceFormatLevelTrace = { fg = c.comment },
		NoiceFormatLevelWarn = { fg = c.warning },
		NoiceFormatProgressDone = { fg = c.success, bold = true },
		NoiceFormatProgressTodo = { fg = c.comment },
		NoiceFormatTitle = { fg = c.blue, bold = true },

		-- LSP-related highlights
		NoiceLspProgressClient = { fg = c.purple, italic = true },
		NoiceLspProgressSpinner = { fg = c.cyan },
		NoiceLspProgressTitle = { fg = c.blue, bold = true },

		-- Markdown-style formatting in messages
		NoiceAttr = { fg = c.purple, italic = true },
		NoiceReference = { fg = c.cyan, underline = true },
		NoiceTitle = { fg = c.blue, bold = true },

		-- Scrollbar
		NoiceScrollbar = { fg = c.comment, bg = c.bg_4 },
		NoiceScrollbarThumb = { fg = c.fg_darker, bg = c.bg_2 },

		-- Cmdline input dialog
		NoiceCmdlineInput = { fg = c.fg, bg = c.bg_float },
		NoiceCmdlineInputBorder = { fg = c.border, bg = c.bg_float },
		NoiceCmdlineInputTitle = { fg = c.blue, bg = c.bg_float, bold = true },

		-- Hover documentation
		NoiceHover = { fg = c.fg, bg = c.bg_float },
		NoiceHoverBorder = { fg = c.border, bg = c.bg_float },

		-- Message routing and history
		NoiceHistory = { fg = c.fg, bg = c.bg_4 },
		NoiceHistoryBorder = { fg = c.border, bg = c.bg_4 },

		-- Status line components
		NoiceStatusline = { fg = c.fg, bg = c.bg_statusline },
		NoiceStatuslineCommand = { fg = c.blue },
		NoiceStatuslineMode = { fg = c.purple },
		NoiceStatuslineRuler = { fg = c.comment },
		NoiceStatuslineSearch = { fg = c.yellow },

		-- Telescope integration
		NoiceTelescope = { fg = c.fg, bg = c.bg_float },
		NoiceTelescopeBorder = { fg = c.border, bg = c.bg_float },
		NoiceTelescopeTitle = { fg = c.blue, bg = c.bg_float, bold = true },
	}
end

---Apply transparency to noice highlight groups
---@param highlights chalk.Highlights Noice highlight groups
---@param colors chalk.ColorScheme Color scheme
---@return chalk.Highlights Updated highlights with transparency
local function apply_transparency(highlights, colors)
	-- Groups that should become transparent for noice
	local transparent_groups = {
		"NoiceCmdline",
		"NoiceCmdlinePopup",
		"NoiceCmdlinePopupBorder",
		"NoiceCmdlinePopupBorderCmdline",
		"NoiceCmdlinePopupBorderFilter",
		"NoiceCmdlinePopupBorderHelp",
		"NoiceCmdlinePopupBorderIncRename",
		"NoiceCmdlinePopupBorderInput",
		"NoiceCmdlinePopupBorderLua",
		"NoiceCmdlinePopupBorderSearch",
		"NoiceCmdlinePopupBorderSubstitute",
		"NoiceCmdlinePopupTitle",
		"NoiceCmdlinePopupTitleCmdline",
		"NoiceCmdlinePopupTitleFilter",
		"NoiceCmdlinePopupTitleHelp",
		"NoiceCmdlinePopupTitleIncRename",
		"NoiceCmdlinePopupTitleInput",
		"NoiceCmdlinePopupTitleLua",
		"NoiceCmdlinePopupTitleSearch",
		"NoiceCmdlinePopupTitleSubstitute",
		"NoiceConfirm",
		"NoiceConfirmBorder",
		"NoiceMini",
		"NoicePopup",
		"NoicePopupBorder",
		"NoiceSplit",
		"NoiceSplitBorder",
		"NoiceCmdlineInput",
		"NoiceCmdlineInputBorder",
		"NoiceCmdlineInputTitle",
		"NoiceHover",
		"NoiceHoverBorder",
		"NoiceHistory",
		"NoiceHistoryBorder",
		"NoiceStatusline",
		"NoiceTelescope",
		"NoiceTelescopeBorder",
		"NoiceTelescopeTitle",
	}

	-- Groups that Noice automatically links to diagnostic groups
	-- Since we've made DiagnosticSign* groups transparent in the base transparency,
	-- linked groups should inherit transparency naturally. We only need to handle
	-- groups with explicit table definitions.

	-- Apply transparency to regular groups
	for _, group in ipairs(transparent_groups) do
		local highlight = highlights[group]
		if highlight and type(highlight) == "table" then
			---@cast highlight table
			highlight.bg = colors.none
		end
	end

	return highlights
end

---Setup noice highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights noice highlight groups
function M.setup(colors, opts)
	local highlights = get_base_highlights(colors)

	-- Apply transparency if enabled
	if opts.transparent then
		highlights = apply_transparency(highlights, colors)
	end

	return highlights
end

return M
