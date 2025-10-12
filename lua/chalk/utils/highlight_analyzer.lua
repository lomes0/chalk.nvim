-- Utility for analyzing highlight groups and their background colors
-- Useful for debugging transparency issues and understanding colorscheme behavior

local M = {}
local shared = require("chalk.utils.shared")

--- Format a numeric color value to hex string
---@param n number The numeric color value
---@return string The hex color string (e.g., "#ff0000")
local function format_color(n)
	return string.format("#%06x", n)
end

--- List all highlight groups that have non-transparent backgrounds
--- This is useful for debugging transparency issues in colorschemes
function M.list_non_transparent()
	local groups = vim.fn.getcompletion("", "highlight")
	local rows = {}

	for _, group_name in ipairs(groups) do
		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group_name, link = false })
		if ok and hl and hl.bg and type(hl.bg) == "number" then
			table.insert(rows, { group_name, format_color(hl.bg) })
		end
	end

	-- Sort alphabetically by group name
	table.sort(rows, function(a, b)
		return a[1] < b[1]
	end)

	-- Print results
	print(string.rep("-", 60))
	print(string.format("%-35s %s", "Highlight Group", "Background Color"))
	print(string.rep("-", 60))

	for _, row in ipairs(rows) do
		print(string.format("%-35s %s", row[1], row[2]))
	end

	print(string.rep("-", 60))
	print(string.format("Found %d highlight groups with background colors", #rows))
	print("Hint: :verbose hi <Group> to see where it was set.")

	return rows
end

--- Get highlight groups with background colors as a table (for programmatic use)
---@return table Array of {group_name, hex_color} pairs
function M.get_non_transparent()
	local groups = vim.fn.getcompletion("", "highlight")
	local results = {}

	for _, group_name in ipairs(groups) do
		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group_name, link = false })
		if ok and hl and hl.bg and type(hl.bg) == "number" then
			table.insert(results, { group_name, format_color(hl.bg) })
		end
	end

	table.sort(results, function(a, b)
		return a[1] < b[1]
	end)
	return results
end

--- Setup user commands for highlight analysis
function M.setup_commands()
	if not shared.command_utils().check_setup_needed("highlight_analyzer") then
		return
	end

	local commands = {
		ChalkListNonTransparent = {
			callback = M.list_non_transparent,
			opts = { desc = "List all highlight groups with background colors (non-transparent)" },
		},
		ChalkAnalyzeHighlights = {
			callback = M.list_non_transparent,
			opts = { desc = "Analyze highlight groups for transparency issues" },
		},
	}

	shared.command_utils().setup_commands(commands)
end

return M
