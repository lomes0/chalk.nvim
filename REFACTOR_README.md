# Chalk.nvim - Refactored Architecture

The chalk.nvim colorscheme has been completely refactored to follow TokyoNight.nvim architectural patterns for better maintainability, performance, and extensibility.

## New Architecture Overview

```
lua/chalk/
├── init.lua           # Main entry point (simplified, TokyoNight-style)
├── config.lua         # Enhanced configuration with plugin auto-detection
├── theme.lua          # Theme orchestrator and management
├── util.lua           # Color manipulation and utility functions
├── types.lua          # TypeScript-style type definitions
├── colors/
│   ├── init.lua       # Color system orchestrator
│   ├── default.lua    # Default dark variant
│   ├── light.lua      # Light variant
│   └── oled.lua       # OLED variant
└── groups/
    ├── init.lua       # Highlight group orchestrator
    ├── base.lua       # Core editor + syntax highlights
    ├── treesitter.lua # TreeSitter highlights
    └── plugins/       # Plugin-specific highlights
        └── telescope.lua
```

## Key Improvements

### 1. **Modular Color System**
- Separated color variants into individual files
- Colors are processed through a pipeline with blending and contrast checking
- Support for dynamic color generation and manipulation

### 2. **Plugin Auto-Detection**
- Automatically detects available plugins (lazy.nvim, packer.nvim support)
- Intelligent plugin integration without manual configuration
- Fallback for direct module checking

### 3. **Enhanced Configuration**
- TypeScript-style type annotations for better development experience
- Backward compatibility with legacy configuration format
- Performance caching system

### 4. **Better Highlight Management**
- Consolidated base highlights (editor + syntax)
- Plugin-specific highlight modules
- Automatic highlight resolution and linking

### 5. **Developer Experience**
- Comprehensive utility functions for color manipulation
- Type definitions for better IDE support
- Error handling and graceful fallbacks

## Usage

### Basic Setup
```lua
require("chalk").setup({
  variant = "default", -- "default", "light", "oled"
  transparent = false,
  plugins = {
    all = true, -- enable all detected plugins
    treesitter = true,
    telescope = true,
  },
})

vim.cmd.colorscheme("chalk")
```

### Advanced Configuration
```lua
require("chalk").setup({
  variant = "oled",
  light_variant = "light", -- used when vim.o.background = "light"
  cache = true,
  dim_inactive = true,
  
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
  },
  
  on_colors = function(colors)
    colors.primary = "#ff6b6b" -- custom primary color
  end,
  
  on_highlights = function(hl, colors)
    hl.Comment = { fg = colors.comment, italic = true }
  end,
})
```

### Theme Utilities
```lua
-- Toggle between light/dark
require("chalk").toggle()

-- Get colors for current variant
local colors = require("chalk").get_colors()

-- Preview a different variant
local oled_colors = require("chalk").preview("oled")

-- Get theme info
local info = require("chalk").info()
print(vim.inspect(info))
```

## Migration Guide

### Configuration Changes
- `integrations` → `plugins` (with auto-detection)
- `custom_highlights` → `on_highlights` callback
- Added `light_variant`, `cache`, `dim_inactive` options

### API Changes
- `require("chalk").load()` - main theme loader
- `require("chalk").toggle()` - light/dark toggle
- `require("chalk").preview(variant)` - preview variants
- `require("chalk").info()` - theme information

### Plugin Integration
The new system automatically detects and enables plugins, but you can still manually control them:

```lua
plugins = {
  auto = true,  -- enable auto-detection
  all = false,  -- don't enable all by default
  telescope = true,  -- manually enable telescope
  nvim_cmp = false,  -- manually disable nvim-cmp
}
```

## Benefits

1. **Better Performance**: Caching system and lazy loading
2. **Easier Maintenance**: Modular structure with clear separation
3. **Enhanced Extensibility**: Easy to add new variants and plugins
4. **Developer Friendly**: Type definitions and comprehensive utilities
5. **Backward Compatibility**: Existing configurations continue to work

The refactored architecture maintains the same visual appearance while providing a much more robust and extensible foundation for future development.
