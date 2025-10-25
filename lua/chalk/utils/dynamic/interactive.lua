-- Interactive color changing functions for chalk.nvim dynamic features
-- Provides user-facing functions for real-time color adjustment

local M = {}
local shared = require("chalk.utils.shared")

---Increase brightness of TreeSitter group under cursor
function M.increase_brightness()
	local treesitter = require("chalk.utils.dynamic.treesitter")
	local adjustment = require("chalk.utils.dynamic.adjustment")

	-- Get TreeSitter capture at cursor
	local capture = treesitter.get_ts_capture_at_cursor()
	if not capture then
		shared.notify("No TreeSitter capture found at cursor", vim.log.levels.WARN, "Dynamic")
		return
	end

	-- Attempt to increase brightness
	local new_color = adjustment.increase_brightness(capture)
	if new_color then
		shared.notify(
			string.format("Increased brightness: %s → %s", capture, new_color),
			vim.log.levels.INFO,
			"Dynamic"
		)
	end
end

---Decrease brightness of TreeSitter group under cursor
function M.decrease_brightness()
	local treesitter = require("chalk.utils.dynamic.treesitter")
	local adjustment = require("chalk.utils.dynamic.adjustment")

	local capture = treesitter.get_ts_capture_at_cursor()
	if not capture then
		shared.notify("No TreeSitter capture found at cursor", vim.log.levels.WARN, "Dynamic")
		return
	end

	local new_color = adjustment.decrease_brightness(capture)
	if new_color then
		shared.notify(
			string.format("Decreased brightness: %s → %s", capture, new_color),
			vim.log.levels.INFO,
			"Dynamic"
		)
	end
end

---Change color in a specific direction (next/previous in color wheel)
---@param direction number Direction: 1 for next, -1 for previous
function M.change_color(direction)
	local treesitter = require("chalk.utils.dynamic.treesitter")
	local adjustment = require("chalk.utils.dynamic.adjustment")

	local capture = treesitter.get_ts_capture_at_cursor()
	if not capture then
		shared.notify("No TreeSitter capture found at cursor", vim.log.levels.WARN, "Dynamic")
		return
	end

	-- Use hue adjustment for color changing
	local hue_step = 30 -- 30 degrees
	local new_color = adjustment.adjust_hue(capture, direction * hue_step)

	if new_color then
		local direction_text = direction > 0 and "next" or "previous"
		shared.notify(
			string.format("Changed to %s color: %s → %s", direction_text, capture, new_color),
			vim.log.levels.INFO,
			"Dynamic"
		)
	end
end

---Change color by family variation
---@param family string Color family ("warm", "cool", "saturated", "muted")
---@param direction number Direction: 1 for next, -1 for previous
function M.change_color_by_family(family, direction)
	local treesitter = require("chalk.utils.dynamic.treesitter")
	local adjustment = require("chalk.utils.dynamic.adjustment")

	local capture = treesitter.get_ts_capture_at_cursor()
	if not capture then
		shared.notify("No TreeSitter capture found at cursor", vim.log.levels.WARN, "Dynamic")
		return
	end

	local current_color = adjustment.get_group_color(capture)
	if not current_color then
		shared.notify("No color found for capture: " .. capture, vim.log.levels.WARN, "Dynamic")
		return
	end

	local color_utils = shared.color_utils()
	local h, s, l = color_utils.hex_to_hsl(current_color)
	local new_color

	-- Apply family-specific transformations
	if family == "warm" then
		-- Shift towards red/orange/yellow
		local warm_hues = { 0, 15, 30, 45, 60 } -- Red to yellow
		h = warm_hues[math.random(#warm_hues)]
		new_color = color_utils.hsl_to_hex(h, s, l)
	elseif family == "cool" then
		-- Shift towards blue/green/purple
		local cool_hues = { 180, 210, 240, 270, 300 } -- Cyan to purple
		h = cool_hues[math.random(#cool_hues)]
		new_color = color_utils.hsl_to_hex(h, s, l)
	elseif family == "saturated" then
		-- Increase saturation
		s = math.min(100, s + (direction * 20))
		new_color = color_utils.hsl_to_hex(h, s, l)
	elseif family == "muted" then
		-- Decrease saturation
		s = math.max(20, s - (direction * 20))
		new_color = color_utils.hsl_to_hex(h, s, l)
	else
		-- Default: cycle through color family
		new_color = adjustment.cycle_color_family(capture, direction)
	end

	if new_color then
		adjustment.apply_color_change(capture, new_color)
		shared.notify(
			string.format("Applied %s family color: %s → %s", family, capture, new_color),
			vim.log.levels.INFO,
			"Dynamic"
		)
	end
end

---Reset colors to original theme
function M.reset_colors()
	local overrides = require("chalk.utils.dynamic.overrides")
	overrides.clear_overrides()

	-- Reload colorscheme
	shared.chalk_integration().reload_colorscheme()

	shared.notify("Reset all colors to original theme", vim.log.levels.INFO, "Dynamic")
end

---Inspect the TreeSitter group under cursor
function M.inspect_group()
	local treesitter = require("chalk.utils.dynamic.treesitter")
	local adjustment = require("chalk.utils.dynamic.adjustment")
	local overrides = require("chalk.utils.dynamic.overrides")

	local capture = treesitter.get_ts_capture_at_cursor()
	if not capture then
		shared.notify("No TreeSitter capture found at cursor", vim.log.levels.WARN, "Dynamic")
		return
	end

	-- Get color information
	local current_color = adjustment.get_group_color(capture)
	local has_override = overrides.has_override(capture)
	local override_color = overrides.get_override(capture)

	-- Build inspection message
	local info = {
		string.format("TreeSitter Group: %s", capture),
		string.format("Current Color: %s", current_color or "not found"),
	}

	if has_override then
		table.insert(info, string.format("Override: %s", override_color))
	else
		table.insert(info, "Override: none")
	end

	-- Add HSL breakdown if color exists
	if current_color then
		local color_utils = shared.color_utils()
		local h, s, l = color_utils.hex_to_hsl(current_color)
		table.insert(info, string.format("HSL: %.0f°, %.0f%%, %.0f%%", h, s, l))
	end

	-- Show in a popup or notification
	local message = table.concat(info, "\n")
	shared.notify(message, vim.log.levels.INFO, "Dynamic")
end

---Show current changes and overrides
function M.show_changes()
	local overrides = require("chalk.utils.dynamic.overrides")
	local override_data = overrides.load_overrides()

	if vim.tbl_count(override_data) == 0 then
		shared.notify("No active color overrides", vim.log.levels.INFO, "Dynamic")
		return
	end

	-- Create a buffer to show changes
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 60,
		height = 20,
		row = 5,
		col = 10,
		border = "rounded",
		title = "Active Color Overrides",
	})

	local lines = { "Active Color Overrides:", "" }

	-- Sort overrides for consistent display
	local sorted_groups = vim.tbl_keys(override_data)
	table.sort(sorted_groups)

	for _, group_name in ipairs(sorted_groups) do
		local color = override_data[group_name]
		table.insert(lines, string.format("%s → %s", group_name, color))
	end

	table.insert(lines, "")
	table.insert(lines, "Press 'q' to close, 'c' to clear all overrides")

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "chalk-overrides")

	-- Add keymaps for the buffer
	local opts = { noremap = true, silent = true, buffer = buf }
	vim.keymap.set("n", "q", ":q<CR>", opts)
	vim.keymap.set("n", "<Esc>", ":q<CR>", opts)
	vim.keymap.set("n", "c", function()
		vim.cmd("q")
		M.reset_colors()
	end, opts)
end

---Generate TreeSitter dump for current buffer
function M.dump_current_buffer()
	local treesitter = require("chalk.utils.dynamic.treesitter")
	local dump = treesitter.dump_treesitter_structure()

	-- Create a buffer to show the dump
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 80,
		height = 30,
		row = 2,
		col = 5,
		border = "rounded",
		title = "TreeSitter Structure Dump",
	})

	local lines = vim.split(dump, "\n")
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "treesitter-dump")

	-- Add close keymap
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":q<CR>", { noremap = true, silent = true })
end

return M
