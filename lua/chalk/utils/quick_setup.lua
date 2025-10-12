-- Quick setup script for chalk utilities
-- Add this to your init.lua for easy activation

local M = {}

---Quick setup with sensible defaults
---@param opts? table Optional configuration
function M.quick_setup(opts)
	opts = vim.tbl_extend("force", {
		-- Chalk options
		variant = "default",
		transparent = false,
		terminal_colors = true,

		-- Utils options
		enable_dynamic = false,
		enable_transparency_commands = false,
	}, opts or {})

	-- Setup chalk colorscheme
	require("chalk").setup(opts)

	-- Setup utilities based on options
	local utils = require("chalk.utils")

	if opts.enable_dynamic then
		utils.dynamic().setup_commands()
	end

	if opts.enable_transparency_commands then
		utils.transparency().setup_commands()
	end

	-- Setup helpful autocmds
	M.setup_autocmds()

	-- Show help message
	vim.defer_fn(function()
		print("🎨 Chalk colorscheme enabled!")
		if opts.enable_dynamic then
			print("Dynamic color adjustment: :ChalkDynamic* commands available")
		end
		if opts.enable_transparency_commands then
			print("Transparency controls: :ChalkTransparency* commands available")
		end
	end, 100)
end

---Setup helpful autocmds for chalk utilities
function M.setup_autocmds()
	local group = vim.api.nvim_create_augroup("ChalkUtils", { clear = true })

	-- Setup colorscheme autocmd for utility features
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		pattern = "chalk*",
		callback = function()
			-- Chalk colorscheme loaded - utilities are available
			vim.g.chalk_utils_available = true
		end,
	})
end

---Setup utilities for specific use cases
---@param use_case "dynamic"|"transparency"|"minimal" The use case to configure for
function M.activate_for_use_case(use_case)
	local configs = {
		dynamic = {
			enable_dynamic = true,
			enable_transparency_commands = false,
		},
		transparency = {
			enable_dynamic = false,
			enable_transparency_commands = true,
		},
		minimal = {
			enable_dynamic = false,
			enable_transparency_commands = false,
		},
	}

	local config = configs[use_case]
	if config then
		M.quick_setup(config)
		vim.notify(string.format("🎨 Chalk configured for %s use case!", use_case), vim.log.levels.INFO)
	else
		vim.notify(string.format("Unknown use case: %s", use_case), vim.log.levels.WARN)
	end
end

-- Export setup function for easy access
_G.ChalkQuickSetup = M.quick_setup

return M
