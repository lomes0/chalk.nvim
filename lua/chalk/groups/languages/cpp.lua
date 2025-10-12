-- C++ TreeSitter highlight groups for chalk.nvim
local M = {}

function M.setup(colors, opts)
	local c = colors

	return {
		-- C++-specific highlights can be added here
		-- ["@constant.macro.cpp"] = { fg = c.copper },
		-- ["@function.builtin.cpp"] = { fg = c.teal_gray },
		-- ["@keyword.directive.cpp"] = { fg = c.indigo },
		-- ["@type.builtin.cpp"] = { fg = c.honey },
	}
end

return M
