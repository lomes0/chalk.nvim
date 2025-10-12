# chalk.nvim - Colorscheme Documentation

## Overview
A sophisticated Neovim colorscheme with dynamic color adjustment capabilities, following TokyoNight.nvim architectural patterns. Features earth-tone base palettes with refined jewel accents, designed for visual harmony and developer productivity.

## Architecture

### Core Structure
```
lua/chalk/
├── init.lua           # Main entry point, API surface
├── config.lua         # Configuration management and defaults
├── theme.lua          # Theme orchestration and application
├── util.lua           # Color utilities (blend, lighten, darken)
├── types.lua          # TypeScript-like type definitions
├── colors/            # Color palette definitions
│   ├── init.lua       # Palette processing and color scheme generation
│   └── default.lua    # Default palette (sophisticated earth tones)
├── groups/            # Highlight group definitions
│   ├── init.lua       # Group orchestration and plugin detection
│   ├── base.lua       # Core Neovim highlights
│   ├── treesitter.lua # TreeSitter syntax highlights
│   ├── languages/     # Language-specific highlights
│   └── plugins/       # Plugin integration highlights
└── utils/             # Advanced utilities
    ├── dynamic/       # Real-time color adjustment system
    ├── shared/        # Common utilities and caching
    └── transparency.lua # Transparency handling
```

## API

### Core Functions
```lua
-- Setup and load colorscheme
require("chalk").setup(opts)     -- Configure without loading
require("chalk").load(opts)      -- Load with options

-- Color access
require("chalk").get_colors(variant)  -- Get color palette
require("chalk").preview(variant)     -- Preview without applying

-- Theme management  
require("chalk").toggle()        -- Switch light/dark variants
require("chalk").info()          -- Get theme metadata

-- Utilities access
require("chalk").utils()         -- Access utility modules
```

### Configuration API
```lua
require("chalk").setup({
  -- Theme variants
  variant = "default",           -- "default", "light", "oled"  
  light_variant = "light",       -- Auto-switch on background change

  -- Visual options
  transparent = false,
  terminal_colors = true,
  dim_inactive = false,

  -- Syntax styling
  styles = {
    comments = { italic = true },
    keywords = { bold = false, italic = false },
    -- ... more style options
  },

  -- Plugin integrations
  plugins = {
    all = false,                 -- Enable all detected plugins
    auto = true,                 -- Auto-detect available plugins
    treesitter = true,
    telescope = true,
    nvim_cmp = true,
    -- ... specific plugin toggles
  },

  -- Customization callbacks
  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
})
```

## Commands

### Dynamic Color Adjustment
- `:ChalkDynamicIncreaseBrightness` - Brighten highlight under cursor
- `:ChalkDynamicDecreaseBrightness` - Darken highlight under cursor  
- `:ChalkDynamicNextColor` - Cycle to next color for group
- `:ChalkDynamicPrevColor` - Cycle to previous color for group
- `:ChalkDynamicWarmColor` - Apply warm color family
- `:ChalkDynamicCoolColor` - Apply cool color family
- `:ChalkDynamicSaturate` - Increase saturation
- `:ChalkDynamicDesaturate` - Decrease saturation
- `:ChalkDynamicReset` - Reset to original colors
- `:ChalkDynamicInspect` - Show group info under cursor
- `:ChalkDynamicShowChanges` - Display current overrides

### Transparency Management
- `:ChalkToggleTransparency` - Toggle transparent backgrounds
- `:ChalkSetTransparency <level>` - Set transparency level (0.0-1.0)

## Implementation Details

### Color System
- **Base Palette**: Earth tones with refined jewel accents
- **Color Families**: Emerald, lime, turquoise, cyan, seafoam, violet (5 shades each)
- **Semantic Colors**: Generated from base palette with perceptual blending
- **Dynamic Processing**: Real-time color manipulation with HSL adjustments

### Plugin Integration
- **Auto-Detection**: Scans for installed plugins using `vim.g.loaded_*` patterns
- **Modular Highlights**: Separate files for each supported plugin
- **Graceful Degradation**: Works without plugin-specific highlights

### Performance Optimizations
- **Caching System**: Avoids repeated color calculations
- **Lazy Loading**: Plugin highlights loaded only when needed  
- **Minimal Runtime**: Core functionality ~2,800 lines (38% reduction from original)

### Type Safety
- **LSP Integration**: Full type definitions for configuration and colors
- **Runtime Validation**: Type checking for user-provided options
- **Documentation**: Inline docs for all public APIs

## Usage Examples

### Basic Setup
```lua
require("chalk").setup({
  variant = "default",
  transparent = false,
})
vim.cmd("colorscheme chalk")
```

### Advanced Configuration  
```lua
require("chalk").setup({
  variant = "default",
  styles = {
    comments = { italic = true },
    functions = { bold = true },
  },
  plugins = {
    telescope = true,
    gitsigns = true,
  },
  on_highlights = function(hl, c)
    hl.CursorLine = { bg = c.bg_visual }
  end,
})
```

### Dynamic Adjustments
```lua
-- Setup with dynamic features enabled
require("chalk").setup({
  enable_dynamic_colors = true,
  dynamic_keymaps = true,
  dynamic_prefix = "<leader>c",
})

-- Manual color adjustment
local dynamic = require("chalk.utils.dynamic")
dynamic.increase_brightness("@variable")
```
