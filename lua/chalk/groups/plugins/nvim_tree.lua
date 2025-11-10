-- NvimTree plugin highlights for chalk.nvim
-- Based on the sophisticated chalk color scheme with earth tones and refined jewel accents
local M = {}

---Get base NvimTree highlight groups
---@param colors chalk.ColorScheme Color scheme
---@return chalk.Highlights Base NvimTree highlight groups
local function get_base_highlights(colors)
	local c = colors

	return {
		-- === BASIC UI ELEMENTS ===
		-- Window and layout
		NvimTreeNormal = { link = "Normal" },
		NvimTreeNormalFloat = { link = "NormalFloat" },
		NvimTreeNormalFloatBorder = { link = "FloatBorder" },
		NvimTreeNormalNC = { link = "NvimTreeNormal" },
		NvimTreeLineNr = { link = "LineNr" },
		NvimTreeWinSeparator = { link = "WinSeparator" },
		NvimTreeEndOfBuffer = { link = "EndOfBuffer" },
		NvimTreePopup = { link = "Normal" },
		NvimTreeSignColumn = { link = "NvimTreeNormal" },
		NvimTreeCursorColumn = { link = "CursorColumn" },
		NvimTreeCursorLine = { link = "CursorLine" },
		NvimTreeCursorLineNr = { link = "CursorLineNr" },
		NvimTreeStatusLine = { link = "StatusLine" },
		NvimTreeStatusLineNC = { link = "StatusLineNC" },

		-- === FOLDER AND FILE ICONS ===
		-- Folders as structural elements (matching @module, @namespace philosophy)
		NvimTreeFolderIcon = { fg = c.dragon_aqua }, -- Aqua for structure (like @module, @type)
		NvimTreeFileIcon = { fg = c.fg }, -- Neutral foreground for regular files (like @variable)
		NvimTreeSymlinkIcon = { link = "NvimTreeNormal" },
		NvimTreeOpenedFolderIcon = { fg = c.wave_aqua }, -- Brighter aqua when opened
		NvimTreeClosedFolderIcon = { link = "NvimTreeFolderIcon" },

		-- Folder arrows and indent markers - muted for secondary UI
		NvimTreeIndentMarker = { fg = c.dragon_black6 }, -- Very muted (like visual guides)
		NvimTreeFolderArrowClosed = { link = "NvimTreeIndentMarker" },
		NvimTreeFolderArrowOpen = { link = "NvimTreeIndentMarker" },

		-- === FILE AND FOLDER NAMES ===
		-- File types - matching TreeSitter semantic colors
		NvimTreeExecFile = { fg = c.crystal_blue }, -- Blue for executables (like @function)
		NvimTreeImageFile = { fg = c.sakura_pink }, -- Pink for media files (like @constant)
		NvimTreeSpecialFile = { fg = c.dragon_violet }, -- Violet for special files (like @keyword)
		NvimTreeSymlink = { link = "Underlined" },

		-- Folder names
		NvimTreeRootFolder = { link = "Title" },
		NvimTreeFolderName = { link = "Directory" },
		NvimTreeEmptyFolderName = { link = "Directory" },
		NvimTreeOpenedFolderName = { link = "Directory" },
		NvimTreeSymlinkFolderName = { link = "Directory" },

		-- === WINDOW PICKER ===
		-- Window picker with attention accent (matching warning/action philosophy)
		NvimTreeWindowPicker = { fg = c.bg, bg = c.ronin_yellow, bold = true },

		-- === DIAGNOSTIC HIGHLIGHTS ===
		-- Diagnostic folder highlights - link to corresponding file highlights
		NvimTreeDiagnosticWarnFolderHL = { link = "NvimTreeDiagnosticWarnFileHL" },
		NvimTreeDiagnosticErrorFolderHL = { link = "NvimTreeDiagnosticErrorFileHL" },
		NvimTreeDiagnosticHintFolderHL = { link = "NvimTreeDiagnosticHintFileHL" },
		NvimTreeDiagnosticInfoFolderHL = { link = "NvimTreeDiagnosticInfoFileHL" },

		-- Diagnostic file highlights - link to standard diagnostic underlines
		NvimTreeDiagnosticHintFileHL = { link = "DiagnosticUnderlineHint" },
		NvimTreeDiagnosticInfoFileHL = { link = "DiagnosticUnderlineInfo" },
		NvimTreeDiagnosticWarnFileHL = { link = "DiagnosticUnderlineWarn" },
		NvimTreeDiagnosticErrorFileHL = { link = "DiagnosticUnderlineError" },

		-- Diagnostic icons - link to standard diagnostic highlights
		NvimTreeDiagnosticHintIcon = { link = "DiagnosticHint" },
		NvimTreeDiagnosticInfoIcon = { link = "DiagnosticInfo" },
		NvimTreeDiagnosticWarnIcon = { link = "DiagnosticWarn" },
		NvimTreeDiagnosticErrorIcon = { link = "DiagnosticError" },

		-- Legacy LSP diagnostic groups (cleared as per original spec)
		NvimTreeLspDiagnosticsWarningFolderText = {},
		NvimTreeLspDiagnosticsErrorFolderText = {},
		NvimTreeLspDiagnosticsHintText = {},
		NvimTreeLspDiagnosticsInformationText = {},
		NvimTreeLspDiagnosticsWarningText = {},
		NvimTreeLspDiagnosticsErrorText = {},
		NvimTreeLspDiagnosticsHint = {},
		NvimTreeLspDiagnosticsInformation = {},
		NvimTreeLspDiagnosticsWarning = {},
		NvimTreeLspDiagnosticsError = {},
		NvimTreeLspDiagnosticsHintFolderText = {},
		NvimTreeLspDiagnosticsInformationFolderText = {},

		-- === GIT INTEGRATION ===
		-- Git folder highlights - link to corresponding file highlights
		NvimTreeGitFolderStagedHL = { link = "NvimTreeGitFileStagedHL" },
		NvimTreeGitFolderRenamedHL = { link = "NvimTreeGitFileRenamedHL" },
		NvimTreeGitFolderNewHL = { link = "NvimTreeGitFileNewHL" },
		NvimTreeGitFolderMergeHL = { link = "NvimTreeGitFileMergeHL" },
		NvimTreeGitFolderIgnoredHL = { link = "NvimTreeGitFileIgnoredHL" },
		NvimTreeGitFolderDirtyHL = { link = "NvimTreeGitFileDirtyHL" },
		NvimTreeGitFolderDeletedHL = { link = "NvimTreeGitFileDeletedHL" },

		-- Git file highlights - link to corresponding icon highlights
		NvimTreeGitFileStagedHL = { link = "NvimTreeGitStagedIcon" },
		NvimTreeGitFileRenamedHL = { link = "NvimTreeGitRenamedIcon" },
		NvimTreeGitFileNewHL = { link = "NvimTreeGitNewIcon" },
		NvimTreeGitFileMergeHL = { link = "NvimTreeGitMergeIcon" },
		NvimTreeGitFileIgnoredHL = { link = "NvimTreeGitIgnoredIcon" },
		NvimTreeGitFileDirtyHL = { link = "NvimTreeGitDirtyIcon" },
		NvimTreeGitFileDeletedHL = { link = "NvimTreeGitDeletedIcon" },

		-- Git status icons - matching TreeSitter git color philosophy
		NvimTreeGitStagedIcon = { fg = c.wave_aqua }, -- Aqua for staged (structured/ready)
		NvimTreeGitRenamedIcon = { fg = c.ronin_yellow }, -- Yellow for renamed (change)
		NvimTreeGitNewIcon = { fg = c.spring_green }, -- Green for new files (growth)
		NvimTreeGitMergeIcon = { fg = c.dragon_orange }, -- Orange for merge conflicts (attention)
		NvimTreeGitIgnoredIcon = { fg = c.fuji_gray }, -- Gray for ignored (muted)
		NvimTreeGitDeletedIcon = { fg = c.samurai_red }, -- Red for deleted (removal)
		NvimTreeGitDirtyIcon = { fg = c.ronin_yellow }, -- Yellow for modified (change)

		-- Legacy git status groups (cleared as per original spec)
		NvimTreeFolderStaged = {},
		NvimTreeFolderRenamed = {},
		NvimTreeFolderNew = {},
		NvimTreeFolderMerge = {},
		NvimTreeFolderIgnored = {},
		NvimTreeFolderDirty = {},
		NvimTreeFolderDeleted = {},
		NvimTreeFileStaged = {},
		NvimTreeFileRenamed = {},
		NvimTreeFileNew = {},
		NvimTreeFileMerge = {},
		NvimTreeFileIgnored = {},
		NvimTreeFileDirty = {},
		NvimTreeFileDeleted = {},
		NvimTreeGitStaged = {},
		NvimTreeGitRenamed = {},
		NvimTreeGitNew = {},
		NvimTreeGitMerge = {},
		NvimTreeGitIgnored = {},
		NvimTreeGitDeleted = {},
		NvimTreeGitDirty = {},

		-- === FILE STATE INDICATORS ===
		-- Special file states - matching TreeSitter semantic colors
		NvimTreeOpenedHL = { link = "Special" },
		NvimTreeModifiedIcon = { fg = c.ronin_yellow }, -- Yellow for changes (like warnings)
		NvimTreeBookmarkIcon = { fg = c.wave_aqua }, -- Aqua for bookmarks (structural reference)

		-- File state highlights
		NvimTreeModifiedFileHL = { link = "NvimTreeModifiedIcon" },
		NvimTreeModifiedFolderHL = { link = "NvimTreeModifiedFileHL" },
		NvimTreeBookmarkHL = { link = "SpellLocal" },

		-- Legacy file state groups (cleared as per original spec)
		NvimTreeOpenedFile = {},
		NvimTreeModifiedFile = {},
		NvimTreeBookmark = {},

		-- === HIDDEN FILES ===
		-- Hidden file handling - muted like @comment
		NvimTreeHiddenIcon = { fg = c.fuji_gray }, -- Gray for hidden (like comments)
		NvimTreeHiddenFileHL = { fg = c.fg_dim }, -- Dimmed foreground
		NvimTreeHiddenFolderHL = { link = "NvimTreeHiddenFileHL" },
		NvimTreeHiddenDisplay = { fg = c.fuji_gray },

		-- === FILTER AND SEARCH ===
		-- Live filter functionality
		NvimTreeLiveFilterPrefix = { link = "PreProc" },
		NvimTreeLiveFilterValue = { link = "ModeMsg" },

		-- === COPY/CUT OPERATIONS ===
		-- Visual feedback for file operations
		NvimTreeCutHL = { link = "SpellBad" },
		NvimTreeCopiedHL = { link = "SpellRare" },
	}
end

---Apply transparency to NvimTree highlight groups
---@param highlights chalk.Highlights NvimTree highlight groups
---@param colors chalk.ColorScheme Color scheme
---@return chalk.Highlights Updated highlights with transparency
local function apply_transparency(highlights, colors)
	-- Groups that should become transparent for NvimTree
	local transparent_groups = {
		"NvimTreeNormal",
		"NvimTreeNormalFloat",
		"NvimTreeNormalNC",
		"NvimTreeSignColumn",
		"NvimTreeEndOfBuffer",
	}

	for _, group in ipairs(transparent_groups) do
		if highlights[group] and highlights[group].bg then
			---@diagnostic disable-next-line: inject-field
			highlights[group].bg = colors.none
		end
	end

	return highlights
end

---Setup NvimTree highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights NvimTree highlight groups
function M.setup(colors, opts)
	local highlights = get_base_highlights(colors)

	-- Apply transparency if enabled
	if opts.transparent then
		highlights = apply_transparency(highlights, colors)
	end

	return highlights
end

return M
