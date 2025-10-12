-- Which-key plugin highlights for chalk.nvim
local M = {}

---Setup which-key highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights which-key highlight groups
function M.setup(colors, opts)
  local c = colors
  
  return {
    -- Which-key popup window
    WhichKey = { fg = c.blue, bold = true },
    WhichKeyGroup = { fg = c.purple },
    WhichKeyDesc = { fg = c.fg },
    WhichKeySeparator = { fg = c.comment },
    WhichKeyFloat = { bg = c.bg_float },
    WhichKeyBorder = { bg = c.bg_float, fg = c.border },
    WhichKeyValue = { fg = c.comment },
    
    -- Legacy names (for older versions)
    WhichKeySeperator = { fg = c.comment }, -- Note: typo in original plugin
  }
end

return M
