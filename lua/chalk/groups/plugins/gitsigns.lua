-- Gitsigns plugin highlights for chalk.nvim
--
-- Background Color Strategy:
-- - Line highlights: Use subtle diff_*_bg colors (0.1 blend) for gentle indication
-- - Preview highlights: Use stronger diff_*_bg_strong colors (0.15 blend) for clear visibility
-- - Inline highlights: Use medium blend (0.25) for word-level changes
-- - Word highlights: Use stronger blend (0.35) for individual word emphasis
--
local Util = require("chalk.util")

local M = {}

---Setup Gitsigns highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Gitsigns highlight groups
function M.setup(colors, opts)
	local c = colors

	-- Generate staged colors (dimmer versions of regular git colors)
	local staged_add = Util.darken(c.git_add, 0.6)
	local staged_change = Util.darken(c.git_change, 0.6)
	local staged_delete = Util.darken(c.git_delete, 0.6)

	return {
		-- === BASIC SIGNS (Sign column) ===
		GitSignsAdd = { fg = c.git_add },
		GitSignsChange = { fg = c.git_change },
		GitSignsDelete = { fg = c.git_delete },
		GitSignsTopdelete = { fg = c.git_delete },
		GitSignsChangedelete = { fg = c.git_change },
		GitSignsUntracked = { fg = c.git_add },

		-- === LINE HIGHLIGHTS ===
		-- Use the generated diff background colors for subtle line highlighting
		GitSignsAddLn = { bg = c.diff_add_bg },
		GitSignsChangeLn = { bg = c.diff_change_bg },
		GitSignsDeleteLn = { bg = c.diff_delete_bg },
		GitSignsUntrackedLn = { bg = c.diff_add_bg },

		-- === NUMBER HIGHLIGHTS ===
		GitSignsAddNr = { fg = c.git_add },
		GitSignsChangeNr = { fg = c.git_change },
		GitSignsDeleteNr = { fg = c.git_delete },
		GitSignsUntrackedNr = { fg = c.git_add },

		-- === PREVIEW HIGHLIGHTS ===
		-- Use stronger backgrounds for preview visibility
		GitSignsAddPreview = { bg = c.diff_add_bg_strong },
		GitSignsChangePreview = { bg = c.diff_change_bg_strong },
		GitSignsDeletePreview = { bg = c.diff_delete_bg_strong },

		-- === INLINE HIGHLIGHTS ===
		-- Higher opacity for better visibility of appended/changed text
		-- Includes foreground color for better contrast on colored backgrounds
		GitSignsAddInline = {
			bg = Util.blend_bg(c.git_add, 0.25),
			fg = c.fg, -- Ensure text remains visible on colored background
		},
		GitSignsChangeInline = {
			bg = Util.blend_bg(c.git_change, 0.25),
			fg = c.fg, -- Ensure text remains visible on colored background
		},
		GitSignsDeleteInline = {
			bg = Util.blend_bg(c.git_delete, 0.25),
			fg = c.fg, -- Ensure text remains visible on colored background
		},

		-- === CURRENT LINE BLAME ===
		GitSignsCurrentLineBlame = { fg = c.line_number, italic = true },

		-- === LINK GROUPS ===
		-- Number links
		GitSignsChangedeleteNr = "GitSignsChangeNr",
		GitSignsTopdeleteNr = "GitSignsDeleteNr",

		-- Line links
		GitSignsChangedeleteLn = "GitSignsChangeLn",
		GitSignsTopdeleteLn = "GitSignsDeleteLn",

		-- Current line (Cul) links
		GitSignsAddCul = "GitSignsAdd",
		GitSignsChangeCul = "GitSignsChange",
		GitSignsDeleteCul = "GitSignsDelete",
		GitSignsChangedeleteCul = "GitSignsChangeCul",
		GitSignsTopdeleteCul = "GitSignsDeleteCul",
		GitSignsUntrackedCul = "GitSignsAddCul",

		-- === STAGED VERSIONS ===
		-- Staged signs
		GitSignsStagedAdd = { fg = staged_add },
		GitSignsStagedChange = { fg = staged_change },
		GitSignsStagedDelete = { fg = staged_delete },
		GitSignsStagedChangedelete = { fg = staged_change },
		GitSignsStagedTopdelete = { fg = staged_delete },
		GitSignsStagedUntracked = { fg = staged_add },

		-- Staged numbers
		GitSignsStagedAddNr = { fg = staged_add },
		GitSignsStagedChangeNr = { fg = staged_change },
		GitSignsStagedDeleteNr = { fg = staged_delete },
		GitSignsStagedChangedeleteNr = { fg = staged_change },
		GitSignsStagedTopdeleteNr = { fg = staged_delete },
		GitSignsStagedUntrackedNr = { fg = staged_add },

		-- Staged line highlights - use subtle backgrounds for staged changes
		GitSignsStagedAddLn = { bg = c.diff_add_bg },
		GitSignsStagedChangeLn = { bg = c.diff_change_bg },
		GitSignsStagedChangedeleteLn = { bg = c.diff_change_bg },
		GitSignsStagedTopdeleteLn = { bg = c.diff_delete_bg },
		GitSignsStagedUntrackedLn = { bg = c.diff_add_bg },

		-- Staged current line (Cul) highlights
		GitSignsStagedAddCul = { fg = staged_add },
		GitSignsStagedChangeCul = { fg = staged_change },
		GitSignsStagedDeleteCul = { fg = staged_delete },
		GitSignsStagedChangedeleteCul = { fg = staged_change },
		GitSignsStagedTopdeleteCul = { fg = staged_delete },
		GitSignsStagedUntrackedCul = { fg = staged_add },

		-- === INLINE LINE HIGHLIGHTS (Links) ===
		GitSignsAddLnInline = "GitSignsAddInline",
		GitSignsChangeLnInline = "GitSignsChangeInline",
		GitSignsDeleteLnInline = "GitSignsDeleteInline",

		-- === VIRTUAL LINE HIGHLIGHTS ===
		GitSignsDeleteVirtLn = "DiffDelete",
		GitSignsDeleteVirtLnInLine = "GitSignsDeleteLnInline",
		GitSignsVirtLnum = "GitSignsDeleteVirtLn",

		-- === ADDITIONAL PREVIEW HIGHLIGHTS ===
		-- For word-level diff highlighting in previews
		GitSignsAddWord = { bg = Util.blend_bg(c.git_add, 0.35) },
		GitSignsChangeWord = { bg = Util.blend_bg(c.git_change, 0.35) },
		GitSignsDeleteWord = { bg = Util.blend_bg(c.git_delete, 0.35) },
	}
end

return M
