-- Language-specific TreeSitter configurations loader
local M = {}

-- List of supported languages
local SUPPORTED_LANGUAGES = {
	"lua",
	"python",
	"javascript",
	"typescript",
	"rust",
	"go",
	"java",
	"php",
	"ruby",
	"bash",
	"vim",
	"sql",
	"css",
	"html",
	"xml",
	"json",
	"yaml",
	"markdown",
	"c",
	"cpp",
	"dockerfile",
	"toml",
	"gitcommit",
	"diff",
}

---Load all language-specific TreeSitter configurations
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration options
---@return table<string, any> Combined language highlights
function M.load_all(colors, opts)
	local combined_highlights = {}

	for _, language in ipairs(SUPPORTED_LANGUAGES) do
		local ok, lang_module = pcall(require, "chalk.groups.languages." .. language)
		if ok and lang_module.setup then
			local lang_highlights = lang_module.setup(colors, opts)
			-- Merge language highlights into combined table
			for group, config in pairs(lang_highlights) do
				combined_highlights[group] = config
			end
		end
	end

	return combined_highlights
end

---Load specific language TreeSitter configuration
---@param language string Language name
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration options
---@return table<string, any>|nil Language highlights or nil if not found
function M.load_language(language, colors, opts)
	local ok, lang_module = pcall(require, "chalk.groups.languages." .. language)
	if ok and lang_module.setup then
		return lang_module.setup(colors, opts)
	end
	return nil
end

return M
