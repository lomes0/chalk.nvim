-- Rust TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup Rust-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Rust TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- Rust - Enhanced for Better TreeSitter Support
		-- ["@attribute.rust"] = { fg = c.orange }, -- #[derive], #[cfg], etc.
		-- ["@function.builtin.rust"] = { fg = c.primary }, -- println!, vec!, etc.
		-- ["@function.macro.rust"] = { fg = c.purple }, -- Macro definitions
		-- ["@keyword.storage.rust"] = { fg = c.burgundy }, -- mut, const, static
		-- ["@keyword.function.rust"] = { fg = c.violet }, -- fn keyword
		-- ["@function.rust"] = { fg = c.terracotta }, -- fn keyword
		-- ["@keyword.import.rust"] = { fg = c.navy }, -- use statements
		-- ["@keyword.type.rust"] = { fg = c.indigo }, -- struct, enum, impl, trait
		-- ["@type.builtin.rust"] = { fg = c.amber }, -- i32, String, Vec, etc.
		-- ["@variable.builtin.rust"] = { fg = c.rust }, -- self, super, crate
		-- ["@variable.member.rust"] = { fg = c.dusty_rose }, -- Struct field access
		-- ["@module.rust"] = { fg = c.slate_blue }, -- Module references (std::io)
		-- ["@namespace.rust"] = { fg = c.slate_blue }, -- Namespace references
	}
end

return M
