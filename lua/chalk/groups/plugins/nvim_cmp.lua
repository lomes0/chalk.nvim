-- nvim-cmp completion plugin highlights for chalk.nvim
local M = {}

---Setup nvim-cmp highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights nvim-cmp highlight groups
function M.setup(colors, opts)
  local c = colors
  
  return {
    -- Completion menu
    CmpItemAbbr = { fg = c.fg },
    CmpItemAbbrDeprecated = { fg = c.comment, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.blue, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.blue, bold = true },
    
    -- Completion menu background
    CmpItemMenu = { fg = c.comment, italic = true },
    
    -- Completion item kinds
    CmpItemKindDefault = { fg = c.fg },
    CmpItemKindKeyword = { fg = c.purple },
    CmpItemKindVariable = { fg = c.red },
    CmpItemKindConstant = { fg = c.orange },
    CmpItemKindReference = { fg = c.red },
    CmpItemKindValue = { fg = c.red },
    CmpItemKindFunction = { fg = c.blue },
    CmpItemKindMethod = { fg = c.blue },
    CmpItemKindConstructor = { fg = c.yellow },
    CmpItemKindClass = { fg = c.yellow },
    CmpItemKindInterface = { fg = c.yellow },
    CmpItemKindStruct = { fg = c.yellow },
    CmpItemKindEvent = { fg = c.yellow },
    CmpItemKindEnum = { fg = c.yellow },
    CmpItemKindUnit = { fg = c.yellow },
    CmpItemKindModule = { fg = c.blue },
    CmpItemKindProperty = { fg = c.green },
    CmpItemKindField = { fg = c.green },
    CmpItemKindTypeParameter = { fg = c.yellow },
    CmpItemKindEnumMember = { fg = c.orange },
    CmpItemKindOperator = { fg = c.cyan },
    CmpItemKindSnippet = { fg = c.hint },
    CmpItemKindText = { fg = c.fg },
    CmpItemKindFile = { fg = c.fg },
    CmpItemKindFolder = { fg = c.blue },
    CmpItemKindColor = { fg = c.red },
    
    -- Documentation window
    CmpDocumentation = { bg = c.bg_float, fg = c.fg },
    CmpDocumentationBorder = { bg = c.bg_float, fg = c.border },
  }
end

return M
