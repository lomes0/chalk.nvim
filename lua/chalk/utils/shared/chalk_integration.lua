-- Shared chalk integration utilities
-- Consolidates common patterns for loading chalk modules

local M = {}

-- Cache for loaded modules to avoid repeated requires
local _cache = {}

---Load chalk colors with caching
---@return table colors Chalk color scheme
function M.get_colors()
	if not _cache.colors then
		local ok, colors = pcall(require, "chalk.colors.default")
		if not ok then
			vim.notify("Failed to load chalk colors", vim.log.levels.ERROR)
			return {}
		end
		_cache.colors = colors
	end
	return _cache.colors
end

---Load chalk config with caching
---@return table config Chalk configuration
function M.get_config()
	if not _cache.config then
		local ok, config = pcall(require, "chalk.config")
		if not ok then
			vim.notify("Failed to load chalk config", vim.log.levels.WARN)
			return {}
		end
		_cache.config = config
	end
	return _cache.config
end

---Load chalk theme with caching
---@return table theme Chalk theme module
function M.get_theme()
	if not _cache.theme then
		local ok, theme = pcall(require, "chalk.theme")
		if not ok then
			vim.notify("Failed to load chalk theme", vim.log.levels.WARN)
			return {}
		end
		_cache.theme = theme
	end
	return _cache.theme
end

---Clear module cache (useful for development/testing)
function M.clear_cache()
	_cache = {}
end

---Get current chalk configuration
---@return table Current configuration
function M.get_current_config()
	local config_module = M.get_config()
	if config_module.get then
		return config_module.get()
	end
	return config_module
end

---Reload colorscheme with optional config changes
---@param config_changes? table Configuration overrides
function M.reload_colorscheme(config_changes)
	if config_changes then
		local config_module = M.get_config()
		local current_config = M.get_current_config()
		local new_config = vim.tbl_deep_extend("force", current_config, config_changes)

		local theme = M.get_theme()
		if theme.setup then
			theme.setup(new_config)
		end
	else
		-- Simple reload
		pcall(function()
			vim.cmd("colorscheme chalk")
		end)
	end
end

---Check if a highlight group exists
---@param group_name string Highlight group name
---@return boolean exists True if group exists
function M.highlight_group_exists(group_name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group_name, link = false })
	return ok and hl and next(hl) ~= nil
end

---Get highlight group definition
---@param group_name string Highlight group name
---@return table|nil highlight Highlight definition or nil if not found
function M.get_highlight_group(group_name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group_name, link = false })
	if ok and hl and next(hl) then
		return hl
	end
	return nil
end

---Set highlight group with error handling
---@param group_name string Highlight group name
---@param definition table Highlight definition
---@return boolean success True if highlight was set successfully
function M.set_highlight_group(group_name, definition)
	local ok, err = pcall(vim.api.nvim_set_hl, 0, group_name, definition)
	if not ok then
		vim.notify(string.format("Failed to set highlight %s: %s", group_name, err), vim.log.levels.ERROR)
		return false
	end
	return true
end

return M
