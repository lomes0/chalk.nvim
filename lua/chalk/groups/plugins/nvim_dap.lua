-- nvim-dap highlight groups for chalk.nvim
-- Plugin: mfussenegger/nvim-dap
--
-- To configure DAP signs, add this to your nvim-dap config:
--
-- vim.fn.sign_define("DapBreakpoint", {
--   text = "○",
--   texthl = "DapBreakpointSymbol",
--   linehl = "DapBreakpointLine",
--   numhl = "DapBreakpoint",
-- })
--
-- vim.fn.sign_define("DapStopped", {
--   text = "◉",
--   texthl = "DapStoppedSymbol",
--   linehl = "DapStoppedLine",
--   numhl = "DapBreakpoint",
-- })

local M = {}

---Setup nvim-dap highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- DAP (Debug Adapter Protocol)
		DapStoppedLine = { bg = c.bg_p1, fg = c.fg_light, blend = 60 },
		DapBreakpoint = { fg = c.samurai_red },
		DapBreakpointSymbol = { fg = c.samurai_red },
		DapBreakpointLine = { bg = c.bg_p1 },
		DapStoppedSymbol = { fg = c.crystal_blue },
	}
end

return M
