-- Dynamic color adjustment for chalk.nvim
-- Allows real-time color changes for TreeSitter groups under cursor

local M = {}
local Util = require("chalk.util")

-- Cache for current colors and highlights
M._cache = {
	colors = nil,
	highlights = nil,
	config = nil,
}

-- Default values
local DEFAULT_BRIGHTNESS_STEP = 0.1
local MIN_BRIGHTNESS = 0.1
local MAX_BRIGHTNESS = 1.0

---Initialize the dynamic color system
---@param colors? chalk.ColorScheme
---@param highlights? chalk.Highlights
---@param config? chalk.Config
function M.init(colors, highlights, config)
	M._cache.colors = colors or require("chalk.colors").setup()
	M._cache.highlights = highlights or {}
	M._cache.config = config or require("chalk.config").extend()
end

---Get configured brightness step size
---@return number step_size
local function get_brightness_step()
	if M._cache.config and M._cache.config.dynamic_step then
		return M._cache.config.dynamic_step
	end
	return DEFAULT_BRIGHTNESS_STEP
end

---Get TreeSitter capture name at cursor position
---@param bufnr? number Buffer number (0 for current)
---@param row? number Row (0-indexed, defaults to cursor row)
---@param col? number Column (0-indexed, defaults to cursor col)
---@return string|nil capture_name TreeSitter capture name (e.g., "@function", "@variable")
function M.get_ts_capture_at_cursor(bufnr, row, col)
	bufnr = bufnr or 0
	local cursor = vim.api.nvim_win_get_cursor(0)
	row = row or (cursor[1] - 1) -- Convert to 0-indexed
	col = col or cursor[2]

	-- Check if TreeSitter is available for this buffer
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	if not ok or not parser then
		return nil
	end

	-- Get the syntax tree
	local tree = parser:parse()[1]
	if not tree then
		return nil
	end

	-- Find the node at cursor position
	local node = tree:root():descendant_for_range(row, col, row, col)
	if not node then
		return nil
	end

	-- Get TreeSitter highlights for this position
	local captures = vim.treesitter.get_captures_at_pos(bufnr, row, col)
	
	if captures and #captures > 0 then
		-- Return the most specific capture (usually the last one)
		local capture = captures[#captures]
		return "@" .. capture.capture
	end

	-- Fallback: try to get highlight group under cursor
	local synID = vim.fn.synID(row + 1, col + 1, 1)
	if synID > 0 then
		local group_name = vim.fn.synIDattr(synID, "name")
		if group_name and group_name:match("^@") then
			return group_name
		end
	end

	return nil
end

---Get current color value for a highlight group
---@param group_name string Highlight group name
---@return string|nil color Current foreground color (hex)
function M.get_group_color(group_name)
	if not group_name then
		return nil
	end

	-- First check our cached highlights
	if M._cache.highlights and M._cache.highlights[group_name] then
		local hl = M._cache.highlights[group_name]
		if type(hl) == "table" and hl.fg then
			return hl.fg
		elseif type(hl) == "string" then
			-- Handle links
			return M.get_group_color(hl)
		end
	end

	-- Check current Neovim highlight
	local hl = vim.api.nvim_get_hl(0, { name = group_name })
	if hl and hl.fg then
		return string.format("#%06x", hl.fg)
	end

	return nil
end

---Adjust brightness of a color
---@param color string Hex color
---@param adjustment number Brightness adjustment (-1.0 to 1.0)
---@return string adjusted_color Adjusted hex color
function M.adjust_brightness(color, adjustment)
	if not color or not color:match("^#%x%x%x%x%x%x$") then
		return color
	end

	local r, g, b = Util.hex_to_rgb(color)
	
	-- Convert to HSL for better brightness control
	local function rgb_to_hsl(r, g, b)
		r, g, b = r / 255, g / 255, b / 255
		local max = math.max(r, g, b)
		local min = math.min(r, g, b)
		local h, s, l = 0, 0, (max + min) / 2

		if max == min then
			h, s = 0, 0 -- achromatic
		else
			local d = max - min
			s = l > 0.5 and d / (2 - max - min) or d / (max + min)
			if max == r then
				h = (g - b) / d + (g < b and 6 or 0)
			elseif max == g then
				h = (b - r) / d + 2
			elseif max == b then
				h = (r - g) / d + 4
			end
			h = h / 6
		end

		return h, s, l
	end

	local function hsl_to_rgb(h, s, l)
		local function hue_to_rgb(p, q, t)
			if t < 0 then t = t + 1 end
			if t > 1 then t = t - 1 end
			if t < 1/6 then return p + (q - p) * 6 * t end
			if t < 1/2 then return q end
			if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
			return p
		end

		local r, g, b
		if s == 0 then
			r, g, b = l, l, l -- achromatic
		else
			local q = l < 0.5 and l * (1 + s) or l + s - l * s
			local p = 2 * l - q
			r = hue_to_rgb(p, q, h + 1/3)
			g = hue_to_rgb(p, q, h)
			b = hue_to_rgb(p, q, h - 1/3)
		end

		return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
	end

	local h, s, l = rgb_to_hsl(r, g, b)
	
	-- Adjust lightness
	l = math.max(MIN_BRIGHTNESS, math.min(MAX_BRIGHTNESS, l + adjustment))
	
	local new_r, new_g, new_b = hsl_to_rgb(h, s, l)
	return Util.rgb_to_hex(new_r, new_g, new_b)
end

---Apply color change to a TreeSitter group
---@param group_name string TreeSitter group name
---@param new_color string New hex color
function M.apply_color_change(group_name, new_color)
	if not group_name or not new_color then
		return
	end

	-- Update cached highlights
	if not M._cache.highlights then
		M._cache.highlights = {}
	end

	-- Get current highlight definition or create new one
	local current_hl = M._cache.highlights[group_name]
	if type(current_hl) == "string" then
		-- Handle link - create new definition
		current_hl = { fg = new_color }
	elseif type(current_hl) == "table" then
		-- Update existing definition
		current_hl = vim.deepcopy(current_hl)
		current_hl.fg = new_color
	else
		-- Create new definition
		current_hl = { fg = new_color }
	end

	-- Update cache
	M._cache.highlights[group_name] = current_hl

	-- Apply to Neovim
	vim.api.nvim_set_hl(0, group_name, current_hl)

	-- Notify user
	local color_preview = string.format("■", new_color) -- Color block for preview
	vim.notify(string.format("Updated %s: %s %s", group_name, color_preview, new_color), vim.log.levels.INFO)
end

---Increase brightness of TreeSitter group under cursor
function M.increase_brightness()
	local group_name = M.get_ts_capture_at_cursor()
	if not group_name then
		vim.notify("No TreeSitter group found under cursor", vim.log.levels.WARN)
		return
	end

	local current_color = M.get_group_color(group_name)
	if not current_color then
		vim.notify(string.format("No color found for group: %s", group_name), vim.log.levels.WARN)
		return
	end

	local step = get_brightness_step()
	local new_color = M.adjust_brightness(current_color, step)
	M.apply_color_change(group_name, new_color)
end

---Decrease brightness of TreeSitter group under cursor
function M.decrease_brightness()
	local group_name = M.get_ts_capture_at_cursor()
	if not group_name then
		vim.notify("No TreeSitter group found under cursor", vim.log.levels.WARN)
		return
	end

	local current_color = M.get_group_color(group_name)
	if not current_color then
		vim.notify(string.format("No color found for group: %s", group_name), vim.log.levels.WARN)
		return
	end

	local step = get_brightness_step()
	local new_color = M.adjust_brightness(current_color, -step)
	M.apply_color_change(group_name, new_color)
end

---Cycle to next color from palette for TreeSitter group under cursor
function M.change_color()
	local group_name = M.get_ts_capture_at_cursor()
	if not group_name then
		vim.notify("No TreeSitter group found under cursor", vim.log.levels.WARN)
		return
	end

	local current_color = M.get_group_color(group_name)
	
	-- Get available colors from the palette
	local colors = M._cache.colors
	if not colors then
		vim.notify("No color palette available. Initialize chalk first.", vim.log.levels.ERROR)
		return
	end

	-- Create a list of semantic colors from the active color scheme
	local color_list = {
		colors.red,
		colors.orange, 
		colors.yellow,
		colors.green,
		colors.cyan,
		colors.blue,
		colors.purple,
		colors.comment,
		colors.light_gray,
		colors.primary,
		colors.secondary,
		colors.accent,
	}

	-- Filter out nil colors and ensure they're valid hex colors
	local valid_colors = {}
	for _, color in ipairs(color_list) do
		if color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
			table.insert(valid_colors, color)
		end
	end

	if #valid_colors == 0 then
		vim.notify("No valid colors found in palette", vim.log.levels.ERROR)
		return
	end

	-- Find current color index or start from beginning
	local current_index = 1
	if current_color then
		for i, color in ipairs(valid_colors) do
			if color == current_color then
				current_index = i
				break
			end
		end
	end

	-- Get next color (cycle back to first if at end)
	local next_index = (current_index % #valid_colors) + 1
	local next_color = valid_colors[next_index]

	M.apply_color_change(group_name, next_color)
end

---Reset all dynamic color changes (reload theme)
function M.reset_colors()
	-- Reload the theme to reset all changes
	local config = M._cache.config or require("chalk.config").extend()
	local colors, highlights = require("chalk.theme").setup(config)
	
	-- Update cache
	M._cache.colors = colors
	M._cache.highlights = highlights
	
	vim.notify("Colors reset to theme defaults", vim.log.levels.INFO)
end

---Get information about TreeSitter group under cursor
function M.inspect_group()
	local group_name = M.get_ts_capture_at_cursor()
	if not group_name then
		vim.notify("No TreeSitter group found under cursor", vim.log.levels.WARN)
		return
	end

	local current_color = M.get_group_color(group_name)
	local hl = vim.api.nvim_get_hl(0, { name = group_name })
	
	local info = {
		string.format("Group: %s", group_name),
		string.format("Color: %s", current_color or "none"),
	}
	
	if hl then
		if hl.bold then table.insert(info, "Style: bold") end
		if hl.italic then table.insert(info, "Style: italic") end
		if hl.underline then table.insert(info, "Style: underline") end
		if hl.bg then
			table.insert(info, string.format("Background: #%06x", hl.bg))
		end
	end
	
	vim.notify(table.concat(info, "\n"), vim.log.levels.INFO)
end

---Setup keymaps for dynamic color adjustment
---@param opts? table Keymap options
function M.setup_keymaps(opts)
	opts = opts or {}
	local prefix = opts.prefix or ""
	
	local keymaps = {
		{ "!", M.increase_brightness, "Increase brightness" },
		{ "@", M.decrease_brightness, "Decrease brightness" },
		{ "#", M.change_color, "Change color" },
		{ "$", M.reset_colors, "Reset colors" },
		{ "%", M.inspect_group, "Inspect group" },
	}
	
	for _, keymap in ipairs(keymaps) do
		vim.keymap.set("n", keymap[1], keymap[2], { 
			desc = "Chalk: " .. keymap[3],
			silent = true,
		})
	end
	
	vim.notify("Chalk dynamic color keymaps activated: ! (brighter), @ (dimmer), # (change color), $ (reset), % (inspect)", vim.log.levels.INFO)
end

---Setup Ex commands for dynamic color adjustment
function M.setup_commands()
	-- Main command with subcommands
	vim.api.nvim_create_user_command("ChalkDynamic", function(opts)
		local action = opts.fargs[1]
		local arg = opts.fargs[2]
		
		if action == "brighter" or action == "increase" then
			M.increase_brightness()
		elseif action == "darker" or action == "decrease" then
			M.decrease_brightness()
		elseif action == "change" or action == "set" then
			if arg then
				-- Direct color setting
				local group = M.get_ts_capture_at_cursor()
				if group then
					M.apply_color_change(group, arg)
				end
			else
				M.change_color()
			end
		elseif action == "reset" then
			M.reset_colors()
		elseif action == "inspect" or action == "info" then
			M.inspect_group()
		else
			vim.notify("Usage: ChalkDynamic {brighter|darker|change|reset|inspect} [color]", vim.log.levels.ERROR)
		end
	end, {
		nargs = "*",
		complete = function(arglead, cmdline, cursorpos)
			local actions = { "brighter", "darker", "change", "reset", "inspect" }
			if #vim.split(cmdline, " ") <= 2 then
				return vim.tbl_filter(function(action)
					return action:find(arglead, 1, true) == 1
				end, actions)
			end
			return {}
		end,
		desc = "Dynamic color adjustment for TreeSitter groups"
	})
	
	-- Convenience commands
	vim.api.nvim_create_user_command("ChalkBrighter", M.increase_brightness, {
		desc = "Make TreeSitter group under cursor brighter"
	})
	
	vim.api.nvim_create_user_command("ChalkDarker", M.decrease_brightness, {
		desc = "Make TreeSitter group under cursor darker"
	})
	
	vim.api.nvim_create_user_command("ChalkChangeColor", M.change_color, {
		desc = "Change color of TreeSitter group under cursor"
	})
	
	vim.api.nvim_create_user_command("ChalkResetColors", M.reset_colors, {
		desc = "Reset all dynamic color changes"
	})
	
	vim.api.nvim_create_user_command("ChalkInspect", M.inspect_group, {
		desc = "Inspect TreeSitter group under cursor"
	})
end

return M
