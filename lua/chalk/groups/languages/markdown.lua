-- Markdown TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup Markdown-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights Markdown TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	return {
		-- Markdown specific highlights
		["@markup.heading.1.markdown"] = { fg = c.purple, bold = true },
		["@markup.heading.2.markdown"] = { fg = c.blue, bold = true },
		["@markup.heading.3.markdown"] = { fg = c.green, bold = true },
		["@markup.heading.4.markdown"] = { fg = c.yellow, bold = true },
		["@markup.heading.5.markdown"] = { fg = c.red, bold = true },
		["@markup.heading.6.markdown"] = { fg = c.comment, bold = true },
		["@markup.link.markdown"] = { fg = c.info, underline = true },
		["@markup.link.label.markdown"] = { fg = c.green },
		["@markup.link.url.markdown"] = { fg = c.info, underline = true },
		["@markup.raw.markdown"] = { fg = c.green },
		["@markup.raw.block.markdown"] = { fg = c.green },
		["@markup.list.markdown"] = { fg = c.cyan },
		["@markup.emphasis.markdown"] = { italic = true },
		["@markup.strong.markdown"] = { bold = true },
		["@markup.strikethrough.markdown"] = { strikethrough = true },
		["@markup.quote.markdown"] = { fg = c.comment, italic = true },
	}
end

return M
