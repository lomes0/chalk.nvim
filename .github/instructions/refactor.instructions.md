---
applyTo: '**'
---
# Chalk.nvim Refactor Plan: Migration to TokyoNight Structure

## Overview

This document outlines a comprehensive plan to refactor chalk.nvim to follow the TokyoNight.nvim architectural structure. The refactor will improve maintainability, extensibility, and provide a more robust foundation for future development.

## Current vs Target Structure

### Current Structure
```
lua/chalk/
├── colors.lua          # All color definitions and generation
├── config.lua          # Configuration management
├── init.lua            # Main entry point with loading logic
└── groups/
    ├── editor.lua      # Editor highlight groups
    ├── syntax.lua      # Syntax highlight groups
    └── treesitter.lua  # TreeSitter highlight groups
```

### Target Structure (TokyoNight-inspired)
```
lua/chalk/
├── init.lua            # Simplified entry point
├── config.lua          # Enhanced configuration system
├── theme.lua           # Theme orchestration and loading
├── util.lua            # Utility functions for color manipulation
├── types.lua           # Type definitions and annotations
├── colors/
│   ├── init.lua        # Color system orchestration
│   ├── default.lua     # Default dark variant
│   ├── light.lua       # Light variant
│   └── oled.lua        # OLED variant (pure black backgrounds)
├── groups/
│   ├── init.lua        # Group management and plugin detection
│   ├── base.lua        # Core Neovim highlight groups
│   ├── treesitter.lua  # TreeSitter groups
│   └── plugins/
│       ├── telescope.lua
│       ├── nvim_cmp.lua
│       ├── gitsigns.lua
│       └── ...         # Individual plugin support files
└── extra/              # External application themes (future)
    ├── init.lua
    ├── kitty.lua
    ├── alacritty.lua
    └── ...
```

## Migration Steps

### Phase 1: Foundation Setup

#### Step 1.1: Create Type Definitions
**File:** `lua/chalk/types.lua`

```lua
-- Type definitions for better development experience and documentation
---@class chalk.Highlight: vim.api.keyset.highlight
---@field style? vim.api.keyset.highlight

---@alias chalk.Highlights table<string,chalk.Highlight|string>
---@alias chalk.HighlightsFn fun(colors: ColorScheme, opts:chalk.Config):chalk.Highlights

---@class chalk.Config
---@field variant string
---@field light_variant string
---@field transparent boolean
---@field terminal_colors boolean
---@field styles table
---@field dim_inactive boolean
---@field on_colors fun(colors: ColorScheme)
---@field on_highlights fun(highlights: chalk.Highlights, colors: ColorScheme)
---@field cache boolean
---@field plugins table<string, boolean|{enabled:boolean}>

---@class ColorScheme
-- Color palette type definition based on current colors.lua structure
```

#### Step 1.2: Create Utility Module
**File:** `lua/chalk/util.lua`

Based on TokyoNight's util.lua, create functions for:
- Color blending and manipulation
- Module loading utilities
- Color format conversions
- Background/foreground blending helpers

```lua
local M = {}

M.bg = "#1e2328"  -- Default chalk background
M.fg = "#c9c7cd"  -- Default chalk foreground

-- Color manipulation functions
function M.blend(foreground, alpha, background) end
function M.blend_bg(hex, amount, bg) end
function M.blend_fg(hex, amount, fg) end
function M.lighten(hex, amount) end
function M.darken(hex, amount) end

-- Module utilities
function M.mod(modname) end
function M.resolve(groups) end

return M
```

#### Step 1.3: Enhanced Configuration System
**File:** `lua/chalk/config.lua` (Enhanced)

Extend current config to match TokyoNight's capabilities:
- Plugin auto-detection
- Style variants
- Caching system
- Enhanced callback system

### Phase 2: Color System Restructure

#### Step 2.1: Create Color Orchestration
**File:** `lua/chalk/colors/init.lua`

```lua
local Util = require("chalk.util")
local M = {}

---@type table<string, Palette|fun(opts:chalk.Config):Palette>
M.variants = setmetatable({}, {
  __index = function(_, variant)
    return vim.deepcopy(Util.mod("chalk.colors." .. variant))
  end,
})

---@param opts? chalk.Config
function M.setup(opts)
  opts = require("chalk.config").extend(opts)
  
  local palette = M.variants[opts.variant]
  if type(palette) == "function" then
    palette = palette(opts)
  end
  
  -- Process colors similar to TokyoNight's approach
  -- Add computed colors, blends, and transformations
  
  return colors
end

return M
```

#### Step 2.2: Split Color Variants
**Files:** 
- `lua/chalk/colors/default.lua` - Extract current dark theme
- `lua/chalk/colors/light.lua` - Create light variant
- `lua/chalk/colors/oled.lua` - Create OLED variant

Move color definitions from current `colors.lua` into separate variant files.

### Phase 3: Theme Loading System

#### Step 3.1: Create Theme Orchestrator
**File:** `lua/chalk/theme.lua`

```lua
local Util = require("chalk.util")
local M = {}

---@param opts? chalk.Config
function M.setup(opts)
  opts = require("chalk.config").extend(opts)

  local colors = require("chalk.colors").setup(opts)
  local groups = require("chalk.groups").setup(colors, opts)

  -- Clear existing highlights
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "chalk-" .. opts.variant

  -- Apply highlight groups
  for group, hl in pairs(groups) do
    hl = type(hl) == "string" and { link = hl } or hl
    vim.api.nvim_set_hl(0, group, hl)
  end

  -- Apply terminal colors if enabled
  if opts.terminal_colors then
    M.terminal(colors)
  end

  return colors, groups, opts
end

function M.terminal(colors)
  -- Set terminal colors similar to TokyoNight
end

return M
```

#### Step 3.2: Simplify Main Entry Point
**File:** `lua/chalk/init.lua` (Refactored)

```lua
local config = require("chalk.config")
local M = {}

---@type {light?: string, dark?: string}
M.variants = {}

---@param opts? chalk.Config
function M.load(opts)
  opts = require("chalk.config").extend(opts)
  
  -- Handle background/variant logic similar to TokyoNight
  local bg = vim.o.background
  local variant_bg = opts.variant == "light" and "light" or "dark"

  if bg ~= variant_bg then
    if vim.g.colors_name == "chalk-" .. opts.variant then
      opts.variant = bg == "light" and (M.variants.light or "light") or (M.variants.dark or "default")
    else
      vim.o.background = variant_bg
    end
  end
  
  M.variants[vim.o.background] = opts.variant
  return require("chalk.theme").setup(opts)
end

M.setup = config.setup

return M
```

### Phase 4: Group System Enhancement

#### Step 4.1: Create Group Orchestrator
**File:** `lua/chalk/groups/init.lua`

```lua
local Util = require("chalk.util")
local Config = require("chalk.config")
local M = {}

-- Plugin mapping similar to TokyoNight
M.plugins = {
  ["telescope.nvim"] = "telescope",
  ["nvim-cmp"] = "cmp",
  ["gitsigns.nvim"] = "gitsigns",
  -- ... more plugins
}

function M.get_group(name)
  return Util.mod("chalk.groups." .. name)
end

---@param colors ColorScheme
---@param opts chalk.Config
function M.get(name, colors, opts)
  local mod = M.get_group(name)
  return mod.get(colors, opts)
end

---@param colors ColorScheme  
---@param opts chalk.Config
function M.setup(colors, opts)
  local groups = {
    base = true,
    treesitter = true,
  }

  -- Auto-detect plugins (similar to TokyoNight's lazy.nvim detection)
  -- Handle plugin enable/disable logic
  -- Merge all groups
  -- Apply user overrides

  return ret, groups
end

return M
```

#### Step 4.2: Migrate Current Groups
**Files:**
- `lua/chalk/groups/base.lua` - Merge current editor.lua and syntax.lua
- `lua/chalk/groups/treesitter.lua` - Keep current treesitter.lua with new interface

#### Step 4.3: Create Plugin-Specific Groups
**Directory:** `lua/chalk/groups/plugins/`

Create individual files for each plugin integration, following TokyoNight pattern.

### Phase 5: Advanced Features

#### Step 5.1: Caching System
Add caching mechanism similar to TokyoNight for performance optimization.

#### Step 5.2: External Application Support
**Directory:** `lua/chalk/extra/`

Create exporters for external applications:
- Kitty terminal
- Alacritty terminal  
- tmux
- etc.

## Implementation Timeline

### Week 1: Foundation
- [ ] Create `types.lua`
- [ ] Create `util.lua` with basic color functions
- [ ] Enhanced `config.lua`

### Week 2: Color System
- [ ] Create `colors/init.lua`
- [ ] Split variants into separate files
- [ ] Test color generation

### Week 3: Theme Loading
- [ ] Create `theme.lua`
- [ ] Refactor `init.lua`
- [ ] Test basic theme loading

### Week 4: Group System
- [ ] Create `groups/init.lua`
- [ ] Migrate existing groups to new structure
- [ ] Create plugin-specific group files

### Week 5: Polish & Testing
- [ ] Add caching system
- [ ] Comprehensive testing
- [ ] Documentation updates

## Breaking Changes

### Configuration Changes
Users will need to update their configuration:

**Old:**
```lua
require("chalk").setup({
  variant = "default",
  integrations = {
    treesitter = true,
  }
})
```

**New:**
```lua
require("chalk").setup({
  variant = "default", -- or "light", "oled"
  plugins = {
    all = false,
    auto = true,
    treesitter = true,
  }
})
```

### API Changes
- `require("chalk").load()` instead of direct setup
- New callback system for `on_colors` and `on_highlights`
- Plugin detection changes

## Benefits of This Refactor

1. **Modularity**: Clear separation of concerns
2. **Extensibility**: Easy to add new variants and plugins
3. **Performance**: Caching and lazy loading
4. **Maintainability**: Smaller, focused files
5. **Community**: Familiar structure for contributors
6. **Features**: Plugin auto-detection, external app support
7. **Type Safety**: Better development experience with type annotations

## Migration Script

A migration script should be provided to help users transition:

```lua
-- migration_helper.lua
local M = {}

function M.migrate_config(old_config)
  -- Convert old config format to new format
  -- Provide warnings for breaking changes
end

return M
```

## Testing Strategy

1. **Unit Tests**: Test individual modules (colors, utils, groups)
2. **Integration Tests**: Test complete theme loading
3. **Visual Tests**: Screenshot comparisons
4. **Performance Tests**: Benchmark theme loading times
5. **Plugin Tests**: Test with popular plugin combinations

This refactor will transform chalk.nvim into a more professional, maintainable, and feature-rich colorscheme that follows industry best practices while maintaining the unique chalk aesthetic.