-- Dynamic override file management for chalk.nvim
-- Handles loading, saving, and managing color overrides

local M = {}
local shared = require("chalk.utils.shared")

-- Override file path
M.override_file_path = vim.fn.stdpath("config") .. "/chalk-overrides.lua"

---Load overrides from the override file
---@return table overrides Table of highlight group overrides
function M.load_overrides()
	local file_path = M.override_file_path

	-- Check if file exists
	if vim.fn.filereadable(file_path) == 0 then
		return {}
	end

	-- Load the file
	local ok, result = pcall(dofile, file_path)
	if ok and type(result) == "table" then
		return result
	end

	return {}
end

---Save a single override to the override file
---@param group_name string Highlight group name
---@param color string Hex color value
function M.save_override(group_name, color)
	-- Load existing overrides
	local overrides = M.load_overrides()

	-- Update the specific group
	overrides[group_name] = color

	-- Write back to file
	M.write_overrides(overrides)
end

---Write overrides table to the override file
---@param overrides table Table of highlight group overrides
function M.write_overrides(overrides)
	local file_path = M.override_file_path

	-- Create file content
	local lines = {
		"-- Chalk.nvim dynamic color overrides",
		"-- This file is automatically managed by chalk dynamic functions",
		"-- You can edit it manually, but changes may be overwritten",
		"-- Generated on " .. os.date("%Y-%m-%d %H:%M:%S"),
		"",
		"---@type table<string, string>",
		"return {",
	}

	-- Sort override keys for consistent output
	local sorted_keys = vim.tbl_keys(overrides)
	table.sort(sorted_keys)

	for _, group_name in ipairs(sorted_keys) do
		local color = overrides[group_name]
		local comment = string.format(" -- Override for %s", group_name)
		table.insert(lines, string.format('\t["%s"] = "%s",%s', group_name, color, comment))
	end

	table.insert(lines, "}")

	local content = table.concat(lines, "\n")
	local file = io.open(file_path, "w")
	if file then
		file:write(content)
		file:close()
	else
		vim.notify(string.format("Failed to save overrides to %s", file_path), vim.log.levels.ERROR, "Dynamic")
	end
end

---Remove a specific override
---@param group_name string Highlight group name to remove override for
function M.remove_override(group_name)
	local overrides = M.load_overrides()
	overrides[group_name] = nil
	M.write_overrides(overrides)
end

---Clear all overrides
function M.clear_overrides()
	M.write_overrides({})
end

---Apply overrides to highlights
---@param highlights table Highlight groups table
---@param colors table Colors table
---@return table Updated highlights with overrides applied
function M.apply_overrides(highlights, colors)
	local overrides = M.load_overrides()

	if vim.tbl_count(overrides) == 0 then
		return highlights
	end

	-- Create a copy to avoid modifying the original
	local updated_highlights = vim.deepcopy(highlights)

	-- Apply each override
	for group_name, color_override in pairs(overrides) do
		if updated_highlights[group_name] then
			-- Update existing highlight group
			updated_highlights[group_name].fg = color_override
		else
			-- Create new highlight group
			updated_highlights[group_name] = { fg = color_override }
		end
	end

	shared.notify(string.format("Applied %d color overrides", vim.tbl_count(overrides)), vim.log.levels.INFO, "Dynamic")

	return updated_highlights
end

---Get count of current overrides
---@return number count Number of active overrides
function M.get_override_count()
	return vim.tbl_count(M.load_overrides())
end

---Check if a specific group has an override
---@param group_name string Highlight group name
---@return boolean has_override True if group has an override
function M.has_override(group_name)
	local overrides = M.load_overrides()
	return overrides[group_name] ~= nil
end

---Get override for a specific group
---@param group_name string Highlight group name
---@return string|nil color Override color or nil if not found
function M.get_override(group_name)
	local overrides = M.load_overrides()
	return overrides[group_name]
end

return M
