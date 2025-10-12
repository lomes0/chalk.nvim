-- Shared color utility functions for chalk.nvim utils
-- Consolidates HSL/RGB conversion and color manipulation across modules

local M = {}

---Convert HSL to RGB
---@param h number Hue (0-360)
---@param s number Saturation (0-100)
---@param l number Lightness (0-100)
---@return number, number, number r, g, b (0-255)
function M.hsl_to_rgb(h, s, l)
	h = h / 360
	s = s / 100
	l = l / 100

	local function hue_to_rgb(p, q, t)
		if t < 0 then
			t = t + 1
		end
		if t > 1 then
			t = t - 1
		end
		if t < 1 / 6 then
			return p + (q - p) * 6 * t
		end
		if t < 1 / 2 then
			return q
		end
		if t < 2 / 3 then
			return p + (q - p) * (2 / 3 - t) * 6
		end
		return p
	end

	local r, g, b
	if s == 0 then
		r, g, b = l, l, l -- achromatic
	else
		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q
		r = hue_to_rgb(p, q, h + 1 / 3)
		g = hue_to_rgb(p, q, h)
		b = hue_to_rgb(p, q, h - 1 / 3)
	end

	return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
end

---Convert RGB to hex
---@param r number Red (0-255)
---@param g number Green (0-255)
---@param b number Blue (0-255)
---@return string Hex color (#rrggbb)
function M.rgb_to_hex(r, g, b)
	return string.format("#%02x%02x%02x", r, g, b)
end

---Convert HSL to hex
---@param h number Hue (0-360)
---@param s number Saturation (0-100)
---@param l number Lightness (0-100)
---@return string Hex color (#rrggbb)
function M.hsl_to_hex(h, s, l)
	local r, g, b = M.hsl_to_rgb(h, s, l)
	return M.rgb_to_hex(r, g, b)
end

---Convert hex to RGB
---@param hex string Hex color (#rrggbb)
---@return number, number, number r, g, b (0-255)
function M.hex_to_rgb(hex)
	hex = hex:gsub("^#", "")
	local r = tonumber(hex:sub(1, 2), 16) or 0
	local g = tonumber(hex:sub(3, 4), 16) or 0
	local b = tonumber(hex:sub(5, 6), 16) or 0
	return r, g, b
end

---Convert RGB to HSL
---@param r number Red (0-255)
---@param g number Green (0-255)
---@param b number Blue (0-255)
---@return number, number, number h, s, l (h: 0-360, s/l: 0-100)
function M.rgb_to_hsl(r, g, b)
	r, g, b = r / 255, g / 255, b / 255
	local max = math.max(r, g, b)
	local min = math.min(r, g, b)
	local diff = max - min
	local add = max + min
	local l = add * 0.5

	local s, h
	if diff == 0 then
		s, h = 0, 0
	else
		s = l < 0.5 and diff / add or diff / (2 - add)

		if max == r then
			h = ((g - b) / diff) + (g < b and 6 or 0)
		elseif max == g then
			h = (b - r) / diff + 2
		else
			h = (r - g) / diff + 4
		end
		h = h / 6
	end

	return h * 360, s * 100, l * 100
end

---Convert hex to HSL
---@param hex string Hex color (#rrggbb)
---@return number, number, number h, s, l (h: 0-360, s/l: 0-100)
function M.hex_to_hsl(hex)
	local r, g, b = M.hex_to_rgb(hex)
	return M.rgb_to_hsl(r, g, b)
end

---Calculate relative luminance for WCAG contrast
---@param hex string Hex color (#rrggbb)
---@return number Relative luminance (0-1)
function M.relative_luminance(hex)
	local r, g, b = M.hex_to_rgb(hex)

	local function gamma_correct(c)
		c = c / 255
		return c <= 0.03928 and c / 12.92 or math.pow((c + 0.055) / 1.055, 2.4)
	end

	r, g, b = gamma_correct(r), gamma_correct(g), gamma_correct(b)
	return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

---Calculate WCAG contrast ratio
---@param color1 string First color (#rrggbb)
---@param color2 string Second color (#rrggbb)
---@return number Contrast ratio (1-21)
function M.contrast_ratio(color1, color2)
	local l1 = M.relative_luminance(color1)
	local l2 = M.relative_luminance(color2)
	local lighter = math.max(l1, l2)
	local darker = math.min(l1, l2)
	return (lighter + 0.05) / (darker + 0.05)
end

---Adjust brightness of a color
---@param hex string Hex color (#rrggbb)
---@param adjustment number Brightness adjustment (-1.0 to 1.0)
---@param min_brightness? number Minimum brightness (default: 0.1)
---@param max_brightness? number Maximum brightness (default: 1.0)
---@return string Adjusted hex color
function M.adjust_brightness(hex, adjustment, min_brightness, max_brightness)
	min_brightness = min_brightness or 0.1
	max_brightness = max_brightness or 1.0

	local h, s, l = M.hex_to_hsl(hex)
	l = l / 100 -- Convert to 0-1 range

	-- Apply adjustment
	l = math.max(min_brightness, math.min(max_brightness, l + adjustment))

	return M.hsl_to_hex(h, s, l * 100)
end

return M
