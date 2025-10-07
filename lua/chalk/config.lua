local M = {}

-- Default configuration
M.defaults = {
	-- Theme variant
	variant = "default", -- "default", "light", "oled"

	-- Visual options
	transparent = false,
	terminal_colors = true,

	-- Style configurations
	styles = {
		comments = { italic = true },
		keywords = { bold = false, italic = false },
		functions = { bold = false, italic = false },
		variables = { italic = false },
		strings = { italic = false },
		types = { bold = false, italic = false },
	},

	-- Plugin integrations
	integrations = {
		treesitter = true,
		telescope = true,
		nvim_cmp = true,
		gitsigns = true,
		lualine = true,
		which_key = true,
	},

	-- Custom overrides
	custom_highlights = function(colors)
		return {}
	end,

	-- Callback functions
	on_colors = function(colors) end,
	on_highlights = function(highlights, colors) end,
}

-- Current configuration
M.options = {}

-- Setup function
function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

-- Get current configuration
function M.get()
	return M.options or M.defaults
end

return M
