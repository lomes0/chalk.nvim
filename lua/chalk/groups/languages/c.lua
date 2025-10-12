-- C TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		-- C-specific highlights can be added here
		-- ["@constant.macro.c"] = { fg = c.copper },
		-- ["@function.builtin.c"] = { fg = c.teal_gray },
		-- ["@keyword.directive.c"] = { fg = c.indigo },
		-- ["@type.builtin.c"] = { link = "@type.builtin" },
	}
end

return M
