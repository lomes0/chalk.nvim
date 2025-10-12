local Util = require("chalk.util")
local Config = require("chalk.config")

local M = {}

---Plugin to group mapping for organized plugin support
M.plugins = {
  -- Popular plugins with dedicated support
  ["telescope.nvim"] = "telescope",
  ["nvim-cmp"] = "nvim_cmp", 
  ["gitsigns.nvim"] = "gitsigns",
  ["lualine.nvim"] = "lualine",
  ["which-key.nvim"] = "which_key",
  ["indent-blankline.nvim"] = "indent_blankline",
  ["nvim-tree.lua"] = "nvim_tree",
  ["neo-tree.nvim"] = "neo_tree",
  ["bufferline.nvim"] = "bufferline",
  ["dashboard-nvim"] = "dashboard",
  ["alpha-nvim"] = "alpha",
  ["noice.nvim"] = "noice",
  ["nvim-notify"] = "notify",
  ["mini.nvim"] = "mini",
  ["leap.nvim"] = "leap",
  ["flash.nvim"] = "flash",
  ["nvim-navic"] = "navic",
  ["aerial.nvim"] = "aerial",
}

---Get a highlight group module
---@param name string Group name (base, treesitter, or plugin name)
---@return table|nil Group module or nil if not found
function M.get_group(name)
  -- Try plugins directory first (silently to avoid spam)
  local plugin_module = Util.mod("chalk.groups.plugins." .. name, true)
  if plugin_module then
    return plugin_module
  end
  
  -- Try base groups directory (silently for plugins, with errors for base groups)
  local is_base_group = name == "base" or name == "treesitter"
  local base_module = Util.mod("chalk.groups." .. name, not is_base_group)
  return base_module
end

---Load highlight groups from a module
---@param name string Group name
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights|nil Highlight groups or nil if failed
function M.get(name, colors, opts)
  local mod = M.get_group(name)
  if not mod then
    return nil
  end
  
  -- Call the module's setup/get function
  if type(mod.setup) == "function" then
    return mod.setup(colors, opts)
  elseif type(mod.get) == "function" then
    return mod.get(colors, opts)
  elseif type(mod) == "function" then
    return mod(colors, opts)
  end
  
  -- Module should export highlight groups directly
  return mod
end

---Setup all highlight groups based on configuration
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration
---@return chalk.Highlights, table<string, boolean> All highlights and loaded groups
function M.setup(colors, opts)
  local highlights = {}
  local loaded_groups = {}
  
  -- Always load base groups
  local base_groups = { "base", "treesitter" }
  
  for _, group_name in ipairs(base_groups) do
    local group_highlights = M.get(group_name, colors, opts)
    if group_highlights then
      for hl_name, hl_def in pairs(group_highlights) do
        highlights[hl_name] = hl_def
      end
      loaded_groups[group_name] = true
    else
      vim.notify(
        "chalk.nvim: Failed to load base group '" .. group_name .. "'",
        vim.log.levels.WARN
      )
    end
  end
  
  -- Load plugin-specific groups based on configuration
  local enabled_plugins = Config.get_enabled_plugins()
  
  for plugin_name, enabled in pairs(enabled_plugins) do
    if enabled and plugin_name ~= "treesitter" then -- treesitter handled above
      -- Only try to load if the highlight group module actually exists
      if M.has_group(plugin_name) then
        local group_highlights = M.get(plugin_name, colors, opts)
        if group_highlights then
          for hl_name, hl_def in pairs(group_highlights) do
            highlights[hl_name] = hl_def
          end
          loaded_groups[plugin_name] = true
        end
      end
      -- Don't show warnings for missing plugin highlights - it's normal
      -- Most plugins don't need custom highlight groups
    end
  end
  
  return highlights, loaded_groups
end

---Check if a group module exists
---@param name string Group name to check
---@return boolean Whether the group exists
function M.has_group(name)
  return M.get_group(name) ~= nil
end

---Preview groups without applying them
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration  
---@param groups? string[] Specific groups to preview (optional)
---@return chalk.Highlights Preview highlights
function M.preview(colors, opts, groups)
  if groups then
    local highlights = {}
    for _, group_name in ipairs(groups) do
      local group_highlights = M.get(group_name, colors, opts)
      if group_highlights then
        for hl_name, hl_def in pairs(group_highlights) do
          highlights[hl_name] = hl_def
        end
      end
    end
    return highlights
  else
    local highlights, _ = M.setup(colors, opts)
    return highlights
  end
end

return M
