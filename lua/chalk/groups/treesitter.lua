local M = {}

local languages = require("chalk.groups.languages")

---Setup TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	local highlights = {
		-- Annotations
		["@annotation"] = { fg = c.dragon_yellow },
		["@annotation.builtin"] = { fg = c.dragon_yellow, bold = true },

		-- Attributes
		["@attribute"] = { fg = c.dragon_yellow },
		["@attribute.builtin"] = { fg = c.dragon_yellow, bold = true },

		-- Booleans (Kanagawa: pink/violet for constants)
		["@boolean"] = { fg = c.dragon_pink },

		-- Characters
		["@character"] = { fg = c.spring_green },

		-- Comments (Kanagawa: fujiGray - muted natural)
		["@comment"] = { fg = c.fuji_gray },
		["@comment.documentation"] = { fg = c.fuji_gray, italic = true },
		["@comment.error"] = { fg = c.samurai_red, bold = true },
		["@comment.warning"] = { fg = c.ronin_yellow, bold = true },
		["@comment.todo"] = { fg = c.dragon_violet, bg = c.bg_p1, bold = true },
		["@comment.note"] = { fg = c.wave_aqua, bg = c.bg_p1, bold = true },

		-- Constants (Kanagawa: pink/violet family)
		["@constant"] = { fg = c.dragon_pink },
		["@constant.builtin"] = { fg = c.dragon_orange, bold = true },
		["@constant.macro"] = { fg = c.dragon_violet, italic = true },

		-- Functions (Kanagawa: blue tones for trust/reliability)
		["@function"] = { fg = c.vvv },
		["@function.builtin"] = { fg = c.dragon_blue, bold = true },
		["@function.call"] = { fg = c.vvv },
		["@function.macro"] = { fg = c.dragon_aqua, bold = true },
		["@function.method"] = { fg = c.crystal_blue },
		["@function.method.call"] = { fg = c.crystal_blue },

		-- Keywords
		["@keyword"] = { fg = c.dragon_violet }, -- spring_violet
		["@keyword.type"] = { fg = c.sakura_pink }, -- sakura_pink
		["@keyword.conditional"] = { fg = c.dragon_violet }, -- spring_violet
		["@keyword.conditional.ternary"] = { fg = c.dragon_violet }, -- spring_violet
		["@keyword.coroutine"] = { fg = c.dragon_violet, italic = true }, -- dragon_pink
		["@keyword.debug"] = { fg = c.samurai_red, bold = true },
		["@keyword.directive"] = { fg = c.dragon_pink }, -- coral
		["@keyword.directive.define"] = { fg = c.dragon_pink }, -- coral
		["@keyword.exception"] = { fg = c.dragon_pink, bold = true },
		["@keyword.function"] = { fg = c.dragon_pink, bold = true }, -- coral
		["@keyword.import"] = { fg = c.dragon_pink, italic = true }, -- coral
		["@keyword.modifier"] = { fg = c.amethyst }, -- spring_violet
		["@keyword.operator"] = { fg = c.spring_violet }, -- spring_violet
		["@keyword.repeat"] = { fg = c.spring_violet }, -- spring_violet
		["@keyword.return"] = { fg = c.spring_violet }, -- spring_violet
		["@keyword.storage"] = { fg = c.spring_violet }, -- spring_violet

		-- Labels
		["@label"] = { fg = c.dragon_pink },
		["@spell"] = { fg = c.stone_3 },

		-- Literals (Kanagawa: various accent colors)
		["@markup"] = { fg = c.fg_light },
		["@markup.emphasis"] = { italic = true },
		["@markup.strong"] = { bold = true },
		["@markup.environment"] = { fg = c.dragon_yellow },
		["@markup.link"] = { fg = c.crystal_blue, underline = true },
		["@markup.link.label"] = { fg = c.dragon_aqua },
		["@markup.list"] = { fg = c.dragon_pink },
		["@markup.list.checked"] = { fg = c.spring_green },
		["@markup.list.unchecked"] = { fg = c.fuji_gray },
		["@markup.math"] = { fg = c.dragon_violet },
		["@markup.quote"] = { fg = c.fuji_gray, italic = true },
		["@markup.raw"] = { fg = c.spring_green },
		["@markup.underline"] = { underline = true },

		-- Math
		["@math"] = { fg = c.dragon_violet },

		-- Modules (Kanagawa: aqua/teal for structure)
		["@module"] = { fg = c.dragon_aqua },
		["@module.builtin"] = { fg = c.wave_aqua, bold = true },

		-- Namespace
		["@namespace"] = { fg = c.dragon_aqua },

		-- Numbers (Kanagawa: pink/violet for constants)
		["@number"] = { fg = c.dim_orange, bold = true },
		["@number.float"] = { fg = c.sakura_pink },

		-- Operators (Kanagawa: muted foreground)
		["@operator"] = { fg = c.dragon_violet },

		-- Parameters (Kanagawa: neutral foreground)
		["@parameter"] = { fg = c.fg },
		["@parameter.builtin"] = { fg = c.dragon_red, italic = true },
		["@parameter.reference"] = { fg = c.dragon_red },

		-- Properties (Kanagawa: rose/coral for members)
		["@property"] = { fg = c.dragon_red },

		-- Punctuation
		["@punctuation.bracket"] = { fg = c.fg_dim },

		-- Strings (Kanagawa: green tones for growth/content)
		["@string"] = { fg = c.dim_green },
		["@string.json"] = { fg = c.dim_green },
		["@string.documentation"] = { fg = c.fuji_gray, italic = true },
		["@string.escape"] = { fg = c.dragon_red },
		["@string.regex"] = { fg = c.dragon_orange },
		["@string.special"] = { fg = c.dragon_red },
		["@string.special.path"] = { fg = c.wave_aqua, underline = true },
		["@string.special.url"] = { fg = c.crystal_blue, underline = true },

		-- Tags (Kanagawa: pink for markup)
		["@tag"] = { fg = c.dragon_pink },

		-- Types (Kanagawa: aqua/teal for definitions)
		["@type"] = { fg = c.dragon_aqua },
		["@type.builtin"] = { fg = c.dragon_blue, bold = true },
		["@type.definition"] = { fg = c.dragon_aqua, bold = true },
		["@type.qualifier"] = { fg = c.dragon_violet },

		-- Variables (Kanagawa: neutral foreground tones)
		["@variable"] = { fg = c.fg, bold = false }, -- c.fg_light
		["@variable.parameter"] = { fg = c.fg },
		["@variable.member"] = { fg = c.copper },
		["@variable.builtin"] = { fg = c.dragon_red, italic = true },

		-- LSP semantic tokens
		["@lsp.type.class"] = {},
		["@lsp.type.decorator"] = {},
		["@lsp.type.enum"] = {},
		["@lsp.type.enumMember"] = {},
		["@lsp.type.function"] = {},
		["@lsp.type.interface"] = {},
		["@lsp.type.macro"] = {},
		["@lsp.type.method"] = {},
		["@lsp.type.namespace"] = {},
		["@lsp.type.property"] = {},
		["@lsp.type.struct"] = {},
		["@lsp.type.type"] = {},
		["@lsp.type.typeParameter"] = {},
		["@lsp.type.variable"] = {},
		["@lsp.type.keyword"] = {},
		["@lsp.type.parameter"] = { link = "@variable.parameter" },

		-- LSP semantic token modifiers
		["@lsp.mod.deprecated"] = {},
		["@lsp.mod.readonly"] = {},
		["@lsp.mod.static"] = {},

		-- LSP UI elements
		LspCodeLens = { link = "NonText" },
		LspCodeLensSeparator = { link = "LspCodeLens" },
		LspInlayHint = { bg = "none" },
		LspSignatureActiveParameter = { link = "Visual" },

		-- LSP reference highlighting
		LspReferenceRead = { bg = c.bg_p2 },
		LspReferenceText = { bg = c.bg_p2 },
		LspReferenceWrite = { bg = c.bg_p2 },
		LspReferenceTarget = { bg = c.bg_p2 },
	}

	-- Load language-specific highlights and merge them
	local language_highlights = languages.load_all(colors, opts)
	for group, config in pairs(language_highlights) do
		highlights[group] = config
	end

	return highlights
end

return M
