-- Dynamic color adjustment for chalk.nvim
-- Refactored modular system for real-time color changes
--
-- OVERVIEW:
-- - Real-time TreeSitter-based color adjustment under cursor
-- - Persistent override system with file-based storage
-- - Brightness, saturation, hue, and color family adjustments
-- - Interactive commands and keymaps for easy use

local M = {}
local shared = require("chalk.utils.shared")

-- Sub-modules (lazy-loaded)
local _modules = {}

---Get override management module
---@return table overrides Override module
function M.overrides()
	if not _modules.overrides then
		_modules.overrides = require("chalk.utils.dynamic.overrides")
	end
	return _modules.overrides
end

---Get TreeSitter analysis module
---@return table treesitter TreeSitter module
function M.treesitter()
	if not _modules.treesitter then
		_modules.treesitter = require("chalk.utils.dynamic.treesitter")
	end
	return _modules.treesitter
end

---Get color adjustment module
---@return table adjustment Adjustment module
function M.adjustment()
	if not _modules.adjustment then
		_modules.adjustment = require("chalk.utils.dynamic.adjustment")
	end
	return _modules.adjustment
end

---Get interactive functions module
---@return table interactive Interactive module
function M.interactive()
	if not _modules.interactive then
		_modules.interactive = require("chalk.utils.dynamic.interactive")
	end
	return _modules.interactive
end

---Get commands module
---@return table commands Commands module
function M.commands()
	if not _modules.commands then
		_modules.commands = require("chalk.utils.dynamic.commands")
	end
	return _modules.commands
end

-- Legacy API compatibility (delegate to sub-modules)

---Initialize the dynamic color system
---@param colors? table Color scheme
---@param highlights? table Highlights
---@param config? table Configuration
function M.init(colors, highlights, config) end

---Load overrides from file
---@return table overrides Table of highlight group overrides
function M.load_overrides()
	return M.overrides().load_overrides()
end

---Save override for a highlight group
---@param group_name string Highlight group name
---@param color string Hex color value
function M.save_override(group_name, color)
	return M.overrides().save_override(group_name, color)
end

---Clear all overrides
function M.clear_overrides()
	return M.overrides().clear_overrides()
end

---Apply overrides to highlights
---@param highlights table Highlight groups
---@param colors table Colors
---@return table Updated highlights
function M.apply_overrides(highlights, colors)
	return M.overrides().apply_overrides(highlights, colors)
end

---Get TreeSitter capture at cursor
---@param bufnr? number Buffer number
---@param row? number Row position
---@param col? number Column position
---@return string|nil capture TreeSitter capture name
function M.get_ts_capture_at_cursor(bufnr, row, col)
	return M.treesitter().get_ts_capture_at_cursor(bufnr, row, col)
end

---Get color for highlight group
---@param group_name string Highlight group name
---@return string|nil color Hex color
function M.get_group_color(group_name)
	return M.adjustment().get_group_color(group_name)
end

---Adjust brightness of a color
---@param color string Hex color
---@param adjustment number Brightness adjustment
---@return string new_color Adjusted color
function M.adjust_brightness(color, adjustment)
	return shared.color_utils().adjust_brightness(color, adjustment)
end

---Apply color change to highlight group
---@param group_name string Highlight group name
---@param new_color string New hex color
---@param color_var_name? string Color variable name
function M.apply_color_change(group_name, new_color, color_var_name)
	return M.adjustment().apply_color_change(group_name, new_color, color_var_name)
end

-- Interactive functions (most commonly used)

---Increase brightness of TreeSitter group under cursor
function M.increase_brightness()
	return M.interactive().increase_brightness()
end

---Decrease brightness of TreeSitter group under cursor
function M.decrease_brightness()
	return M.interactive().decrease_brightness()
end

---Change color in direction (next/previous)
---@param direction number Direction: 1 for next, -1 for previous
function M.change_color(direction)
	return M.interactive().change_color(direction)
end

---Change color by family
---@param family string Color family ("warm", "cool", "saturated", "muted")
---@param direction number Direction
function M.change_color_by_family(family, direction)
	return M.interactive().change_color_by_family(family, direction)
end

---Reset colors to original
function M.reset_colors()
	return M.interactive().reset_colors()
end

---Inspect TreeSitter group under cursor
function M.inspect_group()
	return M.interactive().inspect_group()
end

---Dump TreeSitter structure for current buffer
function M.dump_treesitter_structure(bufnr)
	return M.treesitter().dump_treesitter_structure(bufnr)
end

-- Utility functions

---Get current changes/overrides
---@return table changes Current changes
function M.get_changes()
	return M.overrides().load_overrides()
end

---Show changes in a buffer
function M.show_changes_in_buffer()
	return M.interactive().show_changes()
end

---Clear change history (compatibility function)
function M.clear_change_history()
	-- In the new modular system, this is handled by clearing overrides
	return M.clear_overrides()
end

-- Setup functions

---Setup dynamic color commands
function M.setup_commands()
	return M.commands().setup_commands()
end

---Setup dynamic color keymaps
---@param opts? table Keymap options
function M.setup_keymaps(opts)
	return M.commands().setup_keymaps(opts)
end

return M
