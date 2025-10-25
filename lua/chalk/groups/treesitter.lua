-- TreeSitter highlight groups - Pastel Softness (Scheme 7)
-- Philosophy: Light shades for gentle, low-contrast comfortable reading
-- Algorithm: Use only _1 and _2 shades from all families for soft, easy-on-eyes experience
local M = {}

-- Import language-specific configurations
local languages = require("chalk.groups.languages")

-- Import types for LSP support
require("chalk.types")

---Setup TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	-- Base TreeSitter highlights (sophisticated and harmonious)
	local highlights = {
		-- Annotations - Sophisticated coral tones
		["@annotation"] = { fg = c.azure_1 },
		["@annotation.builtin"] = { fg = c.azure_1 },

		-- Attributes - Consistent coral family
		["@attribute"] = { fg = c.azure_1 },
		["@attribute.builtin"] = { fg = c.azure_1 },

		-- Booleans - Sophisticated ruby distinction
		["@boolean"] = { fg = c.azure_1 },

		-- Characters - Natural emerald harmony
		["@character"] = { fg = c.emerald_1 },

		-- Comments
		-- ["@comment"] = { fg = c.stone_4, italic = true },
		["@comment"] = {},
		["@comment.documentation"] = { fg = c.azure_1, italic = true },
		["@comment.error"] = { fg = c.azure_1, bold = true },
		["@comment.warning"] = { fg = c.azure_1, bold = true },
		["@comment.todo"] = { fg = c.azure_1, bg = c.bg_3, bold = true },
		["@comment.note"] = { fg = c.azure_1, bg = c.bg_3, bold = true },

		-- Constants - Sophisticated golden hierarchy
		["@constant"] = { fg = c.coral_2 },
		["@constant.builtin"] = { fg = c.copper_2 },
		["@constant.macro"] = { fg = c.azure_1 },

		-- Functions - Enhanced azure visibility
		["@function"] = { fg = c.turquoise_2 },
		["@function.builtin"] = { fg = c.azure_1 },
		["@function.call"] = { fg = c.blue },
		["@function.macro"] = { fg = c.azure_1 },
		["@function.method"] = { fg = c.azure_1 },
		["@function.method.call"] = { fg = c.azure_1 },

		-- Keywords - Pastel softness (only _1 and _2 shades)
		["@keyword"] = { fg = c.mauve_3 },
		["@keyword.type"] = { fg = c.turquoise_2 },
		["@keyword.conditional"] = { fg = c.violet_1 },
		["@keyword.conditional.ternary"] = { fg = c.azure_1 },
		["@keyword.coroutine"] = { fg = c.azure_1, italic = true },
		["@keyword.debug"] = { fg = c.azure_1 },
		["@keyword.directive"] = { fg = c.azure_1 },
		["@keyword.directive.define"] = { fg = c.azure_1 },
		["@keyword.exception"] = { fg = c.azure_1 },
		["@keyword.function"] = { fg = c.indigo_2 },
		["@keyword.import"] = { fg = c.mauve_4 },
		["@keyword.modifier"] = { fg = c.mauve_2 },
		["@keyword.operator"] = { fg = c.azure_1 },
		["@keyword.repeat"] = { fg = c.violet_1 },
		["@keyword.return"] = { fg = c.azure_2 }, -- Warning amber - returns important
		["@keyword.storage"] = { fg = c.azure_1 },

		-- Labels
		["@label"] = { fg = c.azure_1 }, -- Cyan turquoise
		["@spell"] = { fg = c.stone_3 },

		-- Literals
		["@markup"] = { fg = c.azure_1 },
		["@markup.emphasis"] = { italic = true },
		["@markup.environment"] = { fg = c.azure_1 },
		["@markup.link"] = { fg = c.azure_1, underline = true },
		["@markup.link.label"] = { fg = c.azure_1 },
		["@markup.list"] = { fg = c.azure_1 }, -- Turquoise cyan
		["@markup.list.checked"] = { fg = c.azure_1 },
		["@markup.list.unchecked"] = { fg = c.azure_1 },
		["@markup.math"] = { fg = c.azure_1 }, -- Turquoise cyan
		["@markup.quote"] = { fg = c.azure_1, italic = true },
		["@markup.raw"] = { fg = c.azure_1 },
		["@markup.underline"] = { underline = true },

		-- Math
		["@math"] = { fg = c.azure_1 }, -- Turquoise cyan

		-- Modules - Enhanced for Module System
		["@module"] = { fg = c.azure_2 },
		["@module.builtin"] = { fg = c.azure_1, bold = true }, -- Base turquoise - Built-in modules

		-- Namespace support
		["@namespace"] = { fg = c.azure_1 },

		-- Numbers - Sophisticated coral elegance
		["@number"] = { fg = c.yellow, bold = false },
		["@number.float"] = { fg = c.azure_1 },

		-- Operators - Balanced neutrality
		["@operator"] = { fg = c.stone_2 },

		-- Parameters - Refined function signatures
		["@parameter"] = { fg = c.stone_2 },
		["@parameter.builtin"] = { fg = c.azure_1, italic = true },
		["@parameter.reference"] = { fg = c.azure_1 },

		-- Properties - Sophisticated rose elegance
		["@property"] = { fg = c.rose_2 }, -- Base rose - elegant properties

		-- Punctuation - Enhanced visibility
		["@punctuation.bracket"] = { fg = c.azure_1 },

		-- Strings - Sophisticated emerald harmony
		["@string"] = { fg = c.emerald_1 },
		["@string.documentation"] = { fg = c.azure_1, italic = true },
		["@string.escape"] = { fg = c.azure_1 },
		["@string.regex"] = { fg = c.azure_1 }, -- Base lime - regex patterns vibrant
		["@string.special"] = { fg = c.azure_1 },
		["@string.special.path"] = { fg = c.azure_1, underline = true },
		["@string.special.url"] = { fg = c.azure_1, underline = true },

		-- Tags (HTML/XML)
		["@tag"] = { fg = c.azure_1 },

		-- Types - Sophisticated amber hierarchy
		["@type"] = { fg = c.indigo_2 },
		["@type.builtin"] = { fg = c.azure_1, bold = true },
		["@type.definition"] = { fg = c.azure_1, bold = true },
		["@type.qualifier"] = { fg = c.azure_1 },

		-- Variables - Enhanced readability
		["@variable"] = { fg = c.stone_1 },
		["@variable.builtin"] = { fg = c.azure_1, italic = true },
		["@variable.member"] = { fg = "#cc909d" }, -- Base rose - members elegant
		["@variable.parameter"] = { fg = c.stone_3 },

		-- Additional semantic tokens (disabled to prevent TreeSitter interference)
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
		["@lsp.type.parameter"] = { fg = c.stone_1 },

		-- LSP semantic token modifiers (disabled to prevent TreeSitter interference)
		["@lsp.mod.deprecated"] = {},
		["@lsp.mod.readonly"] = {},
		["@lsp.mod.static"] = {},

		-- LSP UI Elements
		LspCodeLens = { link = "NonText" }, -- Code lens annotations (virtual text showing references, implementations, etc.)
		LspCodeLensSeparator = { link = "LspCodeLens" }, -- Separator in code lens
		LspInlayHint = { link = "NonText" }, -- Inlay hints (parameter names, type annotations, etc.)
		LspSignatureActiveParameter = { link = "Visual" }, -- Active parameter in signature help

		-- LSP Reference highlighting (when cursor is on a symbol)
		LspReferenceRead = { bg = c.bg_3 }, -- References where the symbol is read
		LspReferenceText = { bg = c.bg_3 }, -- Text references (fallback)
		LspReferenceWrite = { bg = c.bg_3 }, -- References where the symbol is written/modified
		LspReferenceTarget = { bg = c.bg_3 }, -- Target of the reference
	}

	-- Load language-specific highlights and merge them
	local language_highlights = languages.load_all(colors, opts)
	for group, config in pairs(language_highlights) do
		highlights[group] = config
	end

	return highlights
end

return M
