-- TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights TreeSitter highlight groups
function M.setup(colors, opts)
	local c = colors

	local highlights = {
		-- Annotations
		["@annotation"] = { fg = c.orange },
		["@annotation.builtin"] = { fg = c.orange },

		-- Attributes
		["@attribute"] = { fg = c.orange },
		["@attribute.builtin"] = { fg = c.orange },

		-- Booleans
		["@boolean"] = { fg = c.orange },

		-- Characters
		["@character"] = { fg = c.green },
		["@character.special"] = { fg = c.cyan },

		-- Comments
		["@comment"] = { fg = c.comment, italic = true },
		["@comment.documentation"] = { fg = c.comment, italic = true },
		["@comment.error"] = { fg = c.error, bold = true },
		["@comment.warning"] = { fg = c.warning, bold = true },
		["@comment.todo"] = {
			fg = c.warning,
			bg = c.bg,
			bold = true,
		},
		["@comment.note"] = {
			fg = c.info,
			bg = c.bg,
			bold = true,
		},

		-- Constants
		["@constant"] = { fg = c.yellow },
		["@constant.builtin"] = { fg = c.yellow, bold = true },
		["@constant.macro"] = { fg = c.purple },

		-- Functions
		["@function"] = { fg = c.blue },
		["@function.builtin"] = { fg = c.cyan },
		["@function.call"] = { fg = c.blue },
		["@function.macro"] = { fg = c.purple },
		["@function.method"] = { fg = c.blue },
		["@function.method.call"] = { fg = c.blue },

		-- Keywords
		["@keyword"] = { fg = c.purple },
		["@keyword.conditional"] = { fg = c.purple },
		["@keyword.conditional.ternary"] = { fg = c.purple },
		["@keyword.coroutine"] = { fg = c.purple, italic = true },
		["@keyword.debug"] = { fg = c.error },
		["@keyword.directive"] = { fg = c.purple },
		["@keyword.directive.define"] = { fg = c.purple },
		["@keyword.exception"] = { fg = c.purple },
		["@keyword.function"] = { fg = c.purple },
		["@keyword.import"] = { fg = c.purple },
		["@keyword.operator"] = { fg = c.purple },
		["@keyword.repeat"] = { fg = c.purple },
		["@keyword.return"] = { fg = c.purple },
		["@keyword.storage"] = { fg = c.purple },

		-- Labels
		["@label"] = { fg = c.cyan },

		-- Literals
		["@markup"] = { fg = c.fg },
		["@markup.emphasis"] = { italic = true },
		["@markup.environment"] = { fg = c.purple },
		["@markup.environment.name"] = { fg = c.yellow },
		["@markup.heading"] = { fg = c.purple, bold = true },
		["@markup.heading.1"] = { fg = c.purple, bold = true },
		["@markup.heading.2"] = { fg = c.blue, bold = true },
		["@markup.heading.3"] = { fg = c.green, bold = true },
		["@markup.heading.4"] = { fg = c.yellow, bold = true },
		["@markup.heading.5"] = { fg = c.red, bold = true },
		["@markup.heading.6"] = { fg = c.comment, bold = true },
		["@markup.link"] = { fg = c.info, underline = true },
		["@markup.link.label"] = { fg = c.green },
		["@markup.link.url"] = { fg = c.info, underline = true },
		["@markup.list"] = { fg = c.cyan },
		["@markup.list.checked"] = { fg = c.success },
		["@markup.list.unchecked"] = { fg = c.comment },
		["@markup.math"] = { fg = c.cyan },
		["@markup.quote"] = { fg = c.comment, italic = true },
		["@markup.raw"] = { fg = c.green },
		["@markup.raw.block"] = { fg = c.green },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.strong"] = { bold = true },
		["@markup.underline"] = { underline = true },

		-- Math
		["@math"] = { fg = c.cyan },

		-- Modules
		["@module"] = { fg = c.purple },
		["@module.builtin"] = { fg = c.purple, bold = true },

		-- Numbers
		["@number"] = { fg = c.orange },
		["@number.float"] = { fg = c.orange },

		-- Operators
		["@operator"] = { fg = c.purple },

		-- Parameters
		["@parameter"] = { fg = c.red },
		["@parameter.builtin"] = { fg = c.red, italic = true },
		["@parameter.reference"] = { fg = c.red },

		-- Properties
		["@property"] = { fg = c.red },

		-- Punctuation
		["@punctuation.bracket"] = { fg = c.light_gray },
		["@punctuation.delimiter"] = { fg = c.light_gray },
		["@punctuation.special"] = { fg = c.cyan },

		-- Strings
		["@string"] = { fg = c.green },
		["@string.documentation"] = { fg = c.comment, italic = true },
		["@string.escape"] = { fg = c.cyan },
		["@string.regex"] = { fg = c.green },
		["@string.special"] = { fg = c.cyan },
		["@string.special.path"] = { fg = c.green, underline = true },
		["@string.special.symbol"] = { fg = c.yellow },
		["@string.special.url"] = { fg = c.info, underline = true },

		-- Tags (HTML/XML)
		["@tag"] = { fg = c.purple },
		["@tag.attribute"] = { fg = c.orange },
		["@tag.delimiter"] = { fg = c.light_gray },

		-- Types
		["@type"] = { fg = c.yellow },
		["@type.builtin"] = { fg = c.yellow, bold = true },
		["@type.definition"] = { fg = c.yellow },
		["@type.qualifier"] = { fg = c.purple },

		-- Variables
		["@variable"] = { fg = c.red },
		["@variable.builtin"] = { fg = c.red, italic = true },
		["@variable.member"] = { fg = c.red },
		["@variable.parameter"] = { fg = c.red },

		-- Language-specific overrides
		-- Lua
		["@constructor"] = { fg = c.yellow },
		["@constructor.lua"] = { fg = c.light_gray },
		["@function.call.lua"] = { fg = c.blue },
		["@keyword.function.lua"] = { fg = c.purple },
		["@keyword.operator.lua"] = { fg = c.purple },
		["@punctuation.bracket.lua"] = { fg = c.light_gray },
		["@punctuation.delimiter.lua"] = { fg = c.light_gray },
		["@variable.builtin.lua"] = { fg = c.purple },

		-- Python
		["@attribute.python"] = { fg = c.orange },
		["@constructor.python"] = { fg = c.yellow },
		["@function.builtin.python"] = { fg = c.cyan },
		["@keyword.operator.python"] = { fg = c.purple },
		["@parameter.python"] = { fg = c.red },
		["@punctuation.special.python"] = { fg = c.purple },
		["@type.builtin.python"] = { fg = c.yellow },
		["@variable.builtin.python"] = { fg = c.purple },

		-- JavaScript/TypeScript
		["@constructor.javascript"] = { fg = c.yellow },
		["@constructor.typescript"] = { fg = c.yellow },
		["@function.method.javascript"] = { fg = c.blue },
		["@function.method.typescript"] = { fg = c.blue },
		["@keyword.export.javascript"] = { fg = c.purple },
		["@keyword.export.typescript"] = { fg = c.purple },
		["@keyword.import.javascript"] = { fg = c.purple },
		["@keyword.import.typescript"] = { fg = c.purple },
		["@property.javascript"] = { fg = c.red },
		["@property.typescript"] = { fg = c.red },
		["@punctuation.bracket.javascript"] = { fg = c.light_gray },
		["@punctuation.bracket.typescript"] = { fg = c.light_gray },
		["@variable.builtin.javascript"] = { fg = c.purple },
		["@variable.builtin.typescript"] = { fg = c.purple },

		-- CSS
		["@property.css"] = { fg = c.red },
		["@string.css"] = { fg = c.green },
		["@type.css"] = { fg = c.yellow },
		["@function.css"] = { fg = c.blue },
		["@number.css"] = { fg = c.orange },
		["@keyword.css"] = { fg = c.purple },
		["@punctuation.delimiter.css"] = { fg = c.light_gray },

		-- JSON
		["@label.json"] = { fg = c.purple },
		["@string.json"] = { fg = c.green },
		["@number.json"] = { fg = c.orange },
		["@boolean.json"] = { fg = c.orange },
		["@constant.json"] = { fg = c.yellow },

		-- YAML
		["@field.yaml"] = { fg = c.purple },
		["@string.yaml"] = { fg = c.green },
		["@number.yaml"] = { fg = c.orange },
		["@boolean.yaml"] = { fg = c.orange },
		["@constant.yaml"] = { fg = c.yellow },
		["@punctuation.delimiter.yaml"] = { fg = c.light_gray },

		-- HTML
		["@tag.html"] = { fg = c.purple },
		["@tag.attribute.html"] = { fg = c.orange },
		["@tag.delimiter.html"] = { fg = c.light_gray },
		["@string.html"] = { fg = c.green },

		-- XML
		["@tag.xml"] = { fg = c.purple },
		["@tag.attribute.xml"] = { fg = c.orange },
		["@tag.delimiter.xml"] = { fg = c.light_gray },
		["@string.xml"] = { fg = c.green },

		-- Markdown
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

		-- C/C++
		["@constant.macro.c"] = { fg = c.purple },
		["@constant.macro.cpp"] = { fg = c.purple },
		["@function.builtin.c"] = { fg = c.cyan },
		["@function.builtin.cpp"] = { fg = c.cyan },
		["@keyword.directive.c"] = { fg = c.purple },
		["@keyword.directive.cpp"] = { fg = c.purple },
		["@type.builtin.c"] = { fg = c.yellow },
		["@type.builtin.cpp"] = { fg = c.yellow },

		-- Go
		["@function.builtin.go"] = { fg = c.cyan },
		["@keyword.function.go"] = { fg = c.purple },
		["@keyword.import.go"] = { fg = c.purple },
		["@type.builtin.go"] = { fg = c.yellow },
		["@variable.builtin.go"] = { fg = c.purple },

		-- Rust
		["@attribute.rust"] = { fg = c.orange },
		["@function.builtin.rust"] = { fg = c.cyan },
		["@function.macro.rust"] = { fg = c.purple },
		["@keyword.storage.rust"] = { fg = c.purple },
		["@type.builtin.rust"] = { fg = c.yellow },
		["@variable.builtin.rust"] = { fg = c.purple },

		-- Java
		["@constant.java"] = { fg = c.yellow },
		["@function.builtin.java"] = { fg = c.cyan },
		["@keyword.import.java"] = { fg = c.purple },
		["@type.builtin.java"] = { fg = c.yellow },
		["@variable.builtin.java"] = { fg = c.purple },

		-- PHP
		["@function.builtin.php"] = { fg = c.cyan },
		["@keyword.operator.php"] = { fg = c.purple },
		["@variable.builtin.php"] = { fg = c.red },

		-- Ruby
		["@function.builtin.ruby"] = { fg = c.cyan },
		["@keyword.function.ruby"] = { fg = c.purple },
		["@symbol.ruby"] = { fg = c.yellow },
		["@variable.builtin.ruby"] = { fg = c.purple },

		-- Shell/Bash
		["@function.builtin.bash"] = { fg = c.cyan },
		["@keyword.function.bash"] = { fg = c.purple },
		["@parameter.bash"] = { fg = c.red },
		["@punctuation.special.bash"] = { fg = c.cyan },
		["@variable.builtin.bash"] = { fg = c.red },

		-- Vim
		["@function.builtin.vim"] = { fg = c.cyan },
		["@keyword.function.vim"] = { fg = c.purple },
		["@variable.builtin.vim"] = { fg = c.red },

		-- SQL
		["@function.builtin.sql"] = { fg = c.cyan },
		["@keyword.sql"] = { fg = c.purple },
		["@type.builtin.sql"] = { fg = c.yellow },

		-- Docker
		["@keyword.dockerfile"] = { fg = c.purple },
		["@string.dockerfile"] = { fg = c.green },

		-- TOML
		["@property.toml"] = { fg = c.purple },
		["@string.toml"] = { fg = c.green },

		-- Git
		["@keyword.gitcommit"] = { fg = c.purple },
		["@string.gitcommit"] = { fg = c.green },

		-- Diff
		["@text.diff.add"] = { fg = c.git_add },
		["@text.diff.delete"] = { fg = c.git_delete },

		-- Additional semantic tokens
		["@lsp.type.class"] = { fg = c.yellow },
		["@lsp.type.decorator"] = { fg = c.orange },
		["@lsp.type.enum"] = { fg = c.yellow },
		["@lsp.type.enumMember"] = { fg = c.yellow },
		["@lsp.type.function"] = { fg = c.blue },
		["@lsp.type.interface"] = { fg = c.yellow },
		["@lsp.type.macro"] = { fg = c.purple },
		["@lsp.type.method"] = { fg = c.blue },
		["@lsp.type.namespace"] = { fg = c.purple },
		["@lsp.type.parameter"] = { fg = c.red },
		["@lsp.type.property"] = { fg = c.red },
		["@lsp.type.struct"] = { fg = c.yellow },
		["@lsp.type.type"] = { fg = c.yellow },
		["@lsp.type.typeParameter"] = { fg = c.yellow },
		["@lsp.type.variable"] = { fg = c.red },

		-- LSP semantic token modifiers
		["@lsp.mod.deprecated"] = { strikethrough = true },
		["@lsp.mod.readonly"] = { italic = true },
		["@lsp.mod.static"] = { bold = true },

		-- Legacy TreeSitter groups (for compatibility)
		TSAnnotation = { link = "@annotation" },
		TSAttribute = { link = "@attribute" },
		TSBoolean = { link = "@boolean" },
		TSCharacter = { link = "@character" },
		TSComment = { link = "@comment" },
		TSConditional = { link = "@keyword.conditional" },
		TSConstant = { link = "@constant" },
		TSConstBuiltin = { link = "@constant.builtin" },
		TSConstMacro = { link = "@constant.macro" },
		TSConstructor = { link = "@constructor" },
		TSError = { fg = c.error },
		TSException = { link = "@keyword.exception" },
		TSField = { link = "@property" },
		TSFloat = { link = "@number.float" },
		TSFunction = { link = "@function" },
		TSFuncBuiltin = { link = "@function.builtin" },
		TSFuncMacro = { link = "@function.macro" },
		TSInclude = { link = "@keyword.import" },
		TSKeyword = { link = "@keyword" },
		TSKeywordFunction = { link = "@keyword.function" },
		TSKeywordOperator = { link = "@keyword.operator" },
		TSKeywordReturn = { link = "@keyword.return" },
		TSLabel = { link = "@label" },
		TSMethod = { link = "@function.method" },
		TSNamespace = { link = "@module" },
		TSNumber = { link = "@number" },
		TSOperator = { link = "@operator" },
		TSParameter = { link = "@parameter" },
		TSParameterReference = { link = "@parameter.reference" },
		TSProperty = { link = "@property" },
		TSPunctDelimiter = { link = "@punctuation.delimiter" },
		TSPunctBracket = { link = "@punctuation.bracket" },
		TSPunctSpecial = { link = "@punctuation.special" },
		TSRepeat = { link = "@keyword.repeat" },
		TSString = { link = "@string" },
		TSStringRegex = { link = "@string.regex" },
		TSStringEscape = { link = "@string.escape" },
		TSStringSpecial = { link = "@string.special" },
		TSSymbol = { link = "@string.special.symbol" },
		TSTag = { link = "@tag" },
		TSTagAttribute = { link = "@tag.attribute" },
		TSTagDelimiter = { link = "@tag.delimiter" },
		TSText = { link = "@markup" },
		TSEmphasis = { link = "@markup.emphasis" },
		TSUnderline = { link = "@markup.underline" },
		TSStrike = { link = "@markup.strikethrough" },
		TSTitle = { link = "@markup.heading" },
		TSLiteral = { link = "@markup.raw" },
		TSURI = { link = "@markup.link.url" },
		TSMath = { link = "@markup.math" },
		TSTextReference = { link = "@markup.link" },
		TSEnvironment = { link = "@markup.environment" },
		TSEnvironmentName = { link = "@markup.environment.name" },
		TSNote = { link = "@comment.note" },
		TSWarning = { link = "@comment.warning" },
		TSDanger = { link = "@comment.error" },
		TSTodo = { link = "@comment.todo" },
		TSType = { link = "@type" },
		TSTypeBuiltin = { link = "@type.builtin" },
		TSTypeQualifier = { link = "@type.qualifier" },
		TSTypeDefinition = { link = "@type.definition" },
		TSVariable = { link = "@variable" },
		TSVariableBuiltin = { link = "@variable.builtin" },
	}

	return highlights
end

return M
