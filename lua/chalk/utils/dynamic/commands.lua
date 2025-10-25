-- Commands and keymaps for chalk.nvim dynamic features
-- Provides user interface for dynamic color adjustment

local M = {}
local shared = require("chalk.utils.shared")

---Setup dynamic color adjustment commands
function M.setup_commands()
	if not shared.command_utils().check_setup_needed("dynamic") then
		return
	end

	local commands = {
		ChalkDynamicIncreaseBrightness = {
			callback = function()
				require("chalk.utils.dynamic.interactive").increase_brightness()
			end,
			opts = { desc = "Increase brightness of TreeSitter group under cursor" },
		},

		ChalkDynamicDecreaseBrightness = {
			callback = function()
				require("chalk.utils.dynamic.interactive").decrease_brightness()
			end,
			opts = { desc = "Decrease brightness of TreeSitter group under cursor" },
		},

		ChalkDynamicNextColor = {
			callback = function()
				require("chalk.utils.dynamic.interactive").change_color(1)
			end,
			opts = { desc = "Change to next color in wheel for group under cursor" },
		},

		ChalkDynamicPrevColor = {
			callback = function()
				require("chalk.utils.dynamic.interactive").change_color(-1)
			end,
			opts = { desc = "Change to previous color in wheel for group under cursor" },
		},

		ChalkDynamicWarmColor = {
			callback = function()
				require("chalk.utils.dynamic.interactive").change_color_by_family("warm", 1)
			end,
			opts = { desc = "Apply warm color family to group under cursor" },
		},

		ChalkDynamicCoolColor = {
			callback = function()
				require("chalk.utils.dynamic.interactive").change_color_by_family("cool", 1)
			end,
			opts = { desc = "Apply cool color family to group under cursor" },
		},

		ChalkDynamicSaturate = {
			callback = function()
				require("chalk.utils.dynamic.interactive").change_color_by_family("saturated", 1)
			end,
			opts = { desc = "Increase saturation of group under cursor" },
		},

		ChalkDynamicDesaturate = {
			callback = function()
				require("chalk.utils.dynamic.interactive").change_color_by_family("muted", 1)
			end,
			opts = { desc = "Decrease saturation of group under cursor" },
		},

		ChalkDynamicReset = {
			callback = function()
				require("chalk.utils.dynamic.interactive").reset_colors()
			end,
			opts = { desc = "Reset all colors to original theme" },
		},

		ChalkDynamicInspect = {
			callback = function()
				require("chalk.utils.dynamic.interactive").inspect_group()
			end,
			opts = { desc = "Inspect TreeSitter group and color under cursor" },
		},

		ChalkDynamicShowChanges = {
			callback = function()
				require("chalk.utils.dynamic.interactive").show_changes()
			end,
			opts = { desc = "Show current color overrides" },
		},

		ChalkDynamicDumpTreeSitter = {
			callback = function()
				require("chalk.utils.dynamic.interactive").dump_current_buffer()
			end,
			opts = { desc = "Show TreeSitter structure for current buffer" },
		},

		-- Override management commands
		ChalkShowOverrides = {
			callback = function()
				local overrides = require("chalk.utils.dynamic.overrides")
				local override_data = overrides.load_overrides()

				if vim.tbl_count(override_data) == 0 then
					shared.notify("No active overrides", vim.log.levels.INFO, "Dynamic")
				else
					require("chalk.utils.dynamic.interactive").show_changes()
				end
			end,
			opts = { desc = "Show current color overrides" },
		},

		ChalkClearOverrides = {
			callback = function()
				require("chalk.utils.dynamic.interactive").reset_colors()
			end,
			opts = { desc = "Clear all color overrides" },
		},

		ChalkEditOverrides = {
			callback = function()
				local overrides = require("chalk.utils.dynamic.overrides")
				vim.cmd("edit " .. overrides.override_file_path)
			end,
			opts = { desc = "Edit override file directly" },
		},
	}

	shared.command_utils().setup_commands(commands)
end

---Setup dynamic color adjustment keymaps
---@param opts? table Keymap options
function M.setup_keymaps(opts)
	opts = opts or {}

	if not shared.command_utils().check_setup_needed("dynamic_keymaps") then
		return
	end

	-- Define keymap prefix (default: <leader>cd for "chalk dynamic")
	local prefix = opts.prefix or "<leader>cd"

	local keymaps = {
		-- Brightness adjustment
		[prefix .. "+"] = {
			mode = "n",
			rhs = ":ChalkDynamicIncreaseBrightness<CR>",
			opts = { desc = "Increase brightness" },
		},
		[prefix .. "-"] = {
			mode = "n",
			rhs = ":ChalkDynamicDecreaseBrightness<CR>",
			opts = { desc = "Decrease brightness" },
		},

		-- Color cycling
		[prefix .. "n"] = {
			mode = "n",
			rhs = ":ChalkDynamicNextColor<CR>",
			opts = { desc = "Next color" },
		},
		[prefix .. "p"] = {
			mode = "n",
			rhs = ":ChalkDynamicPrevColor<CR>",
			opts = { desc = "Previous color" },
		},

		-- Color families
		[prefix .. "w"] = {
			mode = "n",
			rhs = ":ChalkDynamicWarmColor<CR>",
			opts = { desc = "Warm colors" },
		},
		[prefix .. "c"] = {
			mode = "n",
			rhs = ":ChalkDynamicCoolColor<CR>",
			opts = { desc = "Cool colors" },
		},
		[prefix .. "s"] = {
			mode = "n",
			rhs = ":ChalkDynamicSaturate<CR>",
			opts = { desc = "Saturate" },
		},
		[prefix .. "m"] = {
			mode = "n",
			rhs = ":ChalkDynamicDesaturate<CR>",
			opts = { desc = "Mute/desaturate" },
		},

		-- Utilities
		[prefix .. "i"] = {
			mode = "n",
			rhs = ":ChalkDynamicInspect<CR>",
			opts = { desc = "Inspect group" },
		},
		[prefix .. "r"] = {
			mode = "n",
			rhs = ":ChalkDynamicReset<CR>",
			opts = { desc = "Reset colors" },
		},
		[prefix .. "h"] = {
			mode = "n",
			rhs = ":ChalkDynamicShowChanges<CR>",
			opts = { desc = "Show changes" },
		},
		[prefix .. "d"] = {
			mode = "n",
			rhs = ":ChalkDynamicDumpTreeSitter<CR>",
			opts = { desc = "Dump TreeSitter" },
		},
	}

	shared.command_utils().setup_keymaps(keymaps)
end

return M
