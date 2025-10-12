-- Shared command and keymap utilities for chalk.nvim utils
-- Consolidates common command setup patterns

local M = {}

---Create a user command with consistent error handling
---@param name string Command name
---@param callback function|string Command callback
---@param opts table Command options
function M.create_command(name, callback, opts)
	opts = opts or {}

	-- Add consistent error handling if callback is a function
	if type(callback) == "function" then
		local original_callback = callback
		callback = function(...)
			local ok, err = pcall(original_callback, ...)
			if not ok then
				vim.notify(string.format("Error in command %s: %s", name, err), vim.log.levels.ERROR)
			end
		end
	end

	vim.api.nvim_create_user_command(name, callback, opts)
end

---Setup multiple commands from a definition table
---@param commands table<string, {callback: function|string, opts?: table}>
function M.setup_commands(commands)
	for name, def in pairs(commands) do
		M.create_command(name, def.callback, def.opts)
	end
end

---Create a keymap with consistent defaults
---@param mode string|table Keymap mode(s)
---@param lhs string Left-hand side of mapping
---@param rhs string|function Right-hand side of mapping
---@param opts? table Keymap options
function M.create_keymap(mode, lhs, rhs, opts)
	opts = vim.tbl_extend("force", {
		noremap = true,
		silent = true,
	}, opts or {})

	vim.keymap.set(mode, lhs, rhs, opts)
end

---Setup multiple keymaps from a definition table
---@param keymaps table<string, {mode: string|table, rhs: string|function, opts?: table}>
function M.setup_keymaps(keymaps)
	for lhs, def in pairs(keymaps) do
		M.create_keymap(def.mode, lhs, def.rhs, def.opts)
	end
end

---Notify with consistent formatting
---@param message string Message to display
---@param level? number Log level (default: INFO)
---@param title? string Optional title prefix
function M.notify(message, level, title)
	level = level or vim.log.levels.INFO
	local formatted_message = title and string.format("[%s] %s", title, message) or message
	vim.notify(formatted_message, level)
end

---Check if commands are already setup to prevent double-registration
---@param module_name string Name of the module for tracking
---@return boolean setup_needed True if setup is needed
function M.check_setup_needed(module_name)
	local key = "_" .. module_name .. "_commands_setup"
	if _G[key] then
		return false
	end
	_G[key] = true
	return true
end

return M
