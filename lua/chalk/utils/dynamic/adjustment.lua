-- Color adjustment and manipulation for chalk.nvim dynamic features
-- Handles brightness adjustment and color changes

local M = {}
local shared = require("chalk.utils.shared")

-- Default adjustment values
M.DEFAULT_BRIGHTNESS_STEP = 0.1
M.MIN_BRIGHTNESS = 0.1
M.MAX_BRIGHTNESS = 1.0

-- Cache for current colors and config
local _cache = {
	config = nil,
	brightness_step = nil,
}

---Get configured brightness step size
---@return number step_size
local function get_brightness_step()
	if not _cache.brightness_step then
		local config = shared.chalk_integration().get_current_config()
		_cache.brightness_step = (config and config.dynamic_step) or M.DEFAULT_BRIGHTNESS_STEP
	end
	return _cache.brightness_step
end

---Get color for a highlight group
---@param group_name string Highlight group name
---@return string|nil color Hex color or nil if not found
function M.get_group_color(group_name)
	local hl = shared.chalk_integration().get_highlight_group(group_name)
	if hl and hl.fg then
		if type(hl.fg) == "number" then
			return string.format("#%06x", hl.fg)
		elseif type(hl.fg) == "string" then
			return hl.fg
		end
	end
	return nil
end

---Apply a color change to a highlight group
---@param group_name string Highlight group name
---@param new_color string New hex color
---@param color_var_name? string Optional color variable name for reference
function M.apply_color_change(group_name, new_color, color_var_name)
	-- Validate hex color format
	if not new_color or not new_color:match("^#%x%x%x%x%x%x$") then
		shared.notify(
			string.format("Invalid color format: %s", new_color or "nil"),
			vim.log.levels.ERROR,
			"Dynamic"
		)
		return
	end

	-- Apply the color change immediately
	local success = shared.chalk_integration().set_highlight_group(group_name, { fg = new_color })
	
	if success then
		-- Save as override for persistence
		local overrides = require("chalk.utils.dynamic.overrides")
		overrides.save_override(group_name, new_color)
		
		-- Notify about the change
		local message = string.format("Color changed: %s → %s", group_name, new_color)
		if color_var_name then
			message = message .. string.format(" (was %s)", color_var_name)
		end
		
		-- Force a redraw to show changes immediately
		vim.schedule(function()
			vim.cmd("redraw!")
		end)
	end
end

---Increase brightness of a color
---@param group_name string Highlight group name
---@param current_color? string Current color (auto-detected if nil)
---@return string|nil new_color New color or nil if failed
function M.increase_brightness(group_name, current_color)
	current_color = current_color or M.get_group_color(group_name)
	if not current_color then
		shared.notify("No color found for group: " .. group_name, vim.log.levels.WARN, "Dynamic")
		return nil
	end

	local step = get_brightness_step()
	local new_color = shared.color_utils().adjust_brightness(
		current_color, 
		step, 
		M.MIN_BRIGHTNESS, 
		M.MAX_BRIGHTNESS
	)
	
	M.apply_color_change(group_name, new_color)
	return new_color
end

---Decrease brightness of a color
---@param group_name string Highlight group name
---@param current_color? string Current color (auto-detected if nil)
---@return string|nil new_color New color or nil if failed
function M.decrease_brightness(group_name, current_color)
	current_color = current_color or M.get_group_color(group_name)
	if not current_color then
		shared.notify("No color found for group: " .. group_name, vim.log.levels.WARN, "Dynamic")
		return nil
	end

	local step = get_brightness_step()
	local new_color = shared.color_utils().adjust_brightness(
		current_color, 
		-step, 
		M.MIN_BRIGHTNESS, 
		M.MAX_BRIGHTNESS
	)
	
	M.apply_color_change(group_name, new_color)
	return new_color
end

---Adjust saturation of a color
---@param group_name string Highlight group name
---@param adjustment number Saturation adjustment (-1.0 to 1.0)
---@param current_color? string Current color (auto-detected if nil)
---@return string|nil new_color New color or nil if failed
function M.adjust_saturation(group_name, adjustment, current_color)
	current_color = current_color or M.get_group_color(group_name)
	if not current_color then
		shared.notify("No color found for group: " .. group_name, vim.log.levels.WARN, "Dynamic")
		return nil
	end

	local color_utils = shared.color_utils()
	local h, s, l = color_utils.hex_to_hsl(current_color)
	
	-- Apply saturation adjustment
	s = math.max(0, math.min(100, s + (adjustment * 100)))
	
	local new_color = color_utils.hsl_to_hex(h, s, l)
	M.apply_color_change(group_name, new_color)
	return new_color
end

---Adjust hue of a color
---@param group_name string Highlight group name
---@param adjustment number Hue adjustment in degrees (-360 to 360)
---@param current_color? string Current color (auto-detected if nil)
---@return string|nil new_color New color or nil if failed
function M.adjust_hue(group_name, adjustment, current_color)
	current_color = current_color or M.get_group_color(group_name)
	if not current_color then
		shared.notify("No color found for group: " .. group_name, vim.log.levels.WARN, "Dynamic")
		return nil
	end

	local color_utils = shared.color_utils()
	local h, s, l = color_utils.hex_to_hsl(current_color)
	
	-- Apply hue adjustment (wrapping around 360)
	h = (h + adjustment) % 360
	if h < 0 then h = h + 360 end
	
	local new_color = color_utils.hsl_to_hex(h, s, l)
	M.apply_color_change(group_name, new_color)
	return new_color
end

---Cycle through color family variations
---@param group_name string Highlight group name
---@param direction number Direction: 1 for next, -1 for previous
---@return string|nil new_color New color or nil if failed
function M.cycle_color_family(group_name, direction)
	local current_color = M.get_group_color(group_name)
	if not current_color then
		return nil
	end

	-- Get current HSL values
	local color_utils = shared.color_utils()
	local h, s, l = color_utils.hex_to_hsl(current_color)
	
	-- Define color family variations (hue shifts)
	local family_shifts = { -30, -15, 0, 15, 30, 45, 60 } -- Degrees
	
	-- Find closest current position
	local best_match = 1
	local min_diff = math.abs(h - (h + family_shifts[1]))
	
	for i, shift in ipairs(family_shifts) do
		local test_hue = (h + shift) % 360
		local diff = math.abs(h - test_hue)
		if diff < min_diff then
			min_diff = diff
			best_match = i
		end
	end
	
	-- Move to next/previous in family
	local new_index = best_match + direction
	if new_index > #family_shifts then
		new_index = 1
	elseif new_index < 1 then
		new_index = #family_shifts
	end
	
	local new_hue = (h + family_shifts[new_index]) % 360
	local new_color = color_utils.hsl_to_hex(new_hue, s, l)
	
	M.apply_color_change(group_name, new_color)
	return new_color
end

---Reset a highlight group to its original color
---@param group_name string Highlight group name
function M.reset_group_color(group_name)
	local overrides = require("chalk.utils.dynamic.overrides")
	overrides.remove_override(group_name)
	
	-- Reload colorscheme to restore original colors
	shared.chalk_integration().reload_colorscheme()
	
	shared.notify(
		string.format("Reset color for %s", group_name),
		vim.log.levels.INFO,
		"Dynamic"
	)
end

---Clear cache (useful when config changes)
function M.clear_cache()
	_cache = { config = nil, brightness_step = nil }
end

return M
