-- Chalk utilities module
-- Provides access to color generation, dynamic adjustment, and other utility functions
-- Refactored for modularity and reduced interdependencies

local M = {}

-- Lazy-loaded modules to avoid circular dependencies
local _modules = {}

---Access to shared utilities
---@return table Shared utilities module
function M.shared()
	if not _modules.shared then
		_modules.shared = require("chalk.utils.shared")
	end
	return _modules.shared
end

---Access to dynamic color adjustment functions
---@return table Dynamic module
function M.dynamic()
	if not _modules.dynamic then
		_modules.dynamic = require("chalk.utils.dynamic")
	end
	return _modules.dynamic
end

---Access to quick setup utilities
---@return table QuickSetup module
function M.quick_setup()
	if not _modules.quick_setup then
		_modules.quick_setup = require("chalk.utils.quick_setup")
	end
	return _modules.quick_setup
end

---Access to transparency utilities
---@return table Transparency module
function M.transparency()
	if not _modules.transparency then
		_modules.transparency = require("chalk.utils.transparency")
	end
	return _modules.transparency
end

---Access to highlight analyzer utilities
---@return table HighlightAnalyzer module
function M.highlight_analyzer()
	if not _modules.highlight_analyzer then
		_modules.highlight_analyzer = require("chalk.utils.highlight_analyzer")
	end
	return _modules.highlight_analyzer
end

---Setup all utility commands (dynamic, transparency, etc.)
---@param opts? table Options for utility setup
function M.setup_commands(opts)
	opts = opts or {}

	-- Setup dynamic commands
	local dynamic = M.dynamic()
	dynamic.setup_commands()

	-- Setup transparency commands
	local transparency = M.transparency()
	transparency.setup_commands()

	-- Setup highlight analyzer commands
	local highlight_analyzer = M.highlight_analyzer()
	highlight_analyzer.setup_commands()

	local shared = M.shared()
	shared.notify("All chalk utilities commands enabled", vim.log.levels.INFO, "Utils")
end

---Setup all utility keymaps
---@param opts? table Keymap options
function M.setup_keymaps(opts)
	opts = opts or {}

	-- Setup dynamic keymaps
	local dynamic = M.dynamic()
	dynamic.setup_keymaps(opts)

	local shared = M.shared()
end

---Enable all chalk utilities (commands + keymaps)
---@param opts? table Setup options
function M.enable_all(opts)
	opts = opts or {}

	M.setup_commands(opts)

	if opts.keymaps ~= false then
		M.setup_keymaps(opts)
	end

	local shared = M.shared()
	shared.notify("All chalk utilities enabled!", vim.log.levels.INFO, "Utils")
end

return M
