# Chalk.nvim Utils Documentation

The utils directory provides a comprehensive set of utilities for advanced color scheme management, dynamic color adjustments, and developer tools for the Chalk colorscheme.

## 📁 Directory Structure

```
utils/
├── init.lua              # Main utils module with lazy-loaded access
├── dynamic.lua           # Real-time color adjustment system
├── quick_setup.lua       # Quick setup utilities for easy configuration
├── transparency.lua      # Transparency management utilities
├── highlight_analyzer.lua# Highlight group analysis and debugging tools
├── dynamic/              # Dynamic color adjustment sub-modules
│   ├── adjustment.lua    # Color adjustment algorithms
│   ├── commands.lua      # User commands for dynamic features
│   ├── interactive.lua   # Interactive color modification functions
│   ├── overrides.lua     # Persistent color override system
│   └── treesitter.lua    # TreeSitter-based color detection
└── shared/               # Shared utilities to avoid code duplication
    ├── init.lua          # Shared utilities main module
    ├── color_utils.lua   # Color manipulation functions
    ├── command_utils.lua # Command and keymap utilities
    └── chalk_integration.lua # Integration with main chalk module
```

## 🚀 Commands

### Dynamic Adjustment Commands

| Command | Description | Use Case |
|---------|-------------|----------|
| `:ChalkDynamicIncreaseBrightness` | Brighten color under cursor | Make syntax element more visible |
| `:ChalkDynamicDecreaseBrightness` | Darken color under cursor | Make syntax element less prominent |
| `:ChalkDynamicNextColor` | Cycle to next color in wheel | Change color family |
| `:ChalkDynamicPrevColor` | Cycle to previous color | Reverse color cycling |
| `:ChalkDynamicWarmColor` | Apply warm color family | Add warmth to syntax |
| `:ChalkDynamicCoolColor` | Apply cool color family | Add coolness to syntax |
| `:ChalkDynamicClearOverrides` | Remove all color overrides | Reset dynamic changes |
| `:ChalkDynamicShowOverrides` | List active overrides | Debug current modifications |

### Transparency Commands

| Command | Description | Effect |
|---------|-------------|--------|
| `:ChalkTransparencyEnable` | Enable transparency | Makes background transparent |
| `:ChalkTransparencyDisable` | Disable transparency | Restores solid background |
| `:ChalkTransparencyToggle` | Toggle transparency state | Switches between modes |

### Analysis & Debug Commands

| Command | Description | Purpose |
|---------|-------------|---------|
| `:ChalkAnalyzeHighlights` | List non-transparent highlight groups | Debug transparency issues |
| `:ChalkUtilsStatus` | Show utils module status | Check what's enabled |

## 🔧 API Reference

### Core Utils Module (`utils.init`)

```lua
local utils = require('chalk.utils')

-- Lazy-loaded module access
local dynamic = utils.dynamic()
local shared = utils.shared()
local transparency = utils.transparency()
local analyzer = utils.highlight_analyzer()

-- Setup functions
utils.setup_commands()        -- Enable all utility commands
utils.setup_keymaps(opts)     -- Setup default keymaps
utils.enable_all(opts)        -- Enable commands + keymaps
```

### Dynamic Color System API (`utils.dynamic`)

```lua
local dynamic = require('chalk.utils.dynamic')

-- Override management
dynamic.save_override(group_name, color)   -- Save color override
dynamic.load_overrides()                   -- Load saved overrides
dynamic.clear_overrides()                  -- Clear all overrides
dynamic.apply_overrides(highlights, colors) -- Apply to highlights

-- TreeSitter integration
dynamic.get_capture_at_cursor()            -- Get current TreeSitter capture
dynamic.get_highlight_group(capture)       -- Get highlight group for capture

-- Interactive adjustments
local interactive = dynamic.interactive()
interactive.increase_brightness()          -- Brighten cursor element
interactive.decrease_brightness()          -- Darken cursor element
interactive.change_color(direction)        -- Cycle colors (+1/-1)
interactive.change_color_by_family(family, direction) -- Change color family
```

### Shared Utilities API (`utils.shared`)

```lua
local shared = require('chalk.utils.shared')

-- Color utilities
local color_utils = shared.color_utils()
color_utils.hex_to_hsl(hex)               -- Convert hex to HSL
color_utils.hsl_to_hex(h, s, l)           -- Convert HSL to hex
color_utils.adjust_brightness(hex, amount) -- Adjust brightness
color_utils.adjust_saturation(hex, amount) -- Adjust saturation

-- Command utilities
local cmd_utils = shared.command_utils()
cmd_utils.create_command(name, callback, opts) -- Create user command
cmd_utils.create_keymap(mode, key, callback, opts) -- Create keymap
cmd_utils.notify(message, level, title)    -- Show notification

-- Chalk integration
local integration = shared.chalk_integration()
integration.get_colors()                   -- Get current colors
integration.reload_colorscheme(opts)       -- Reload with new options
integration.get_current_config()           -- Get current config
```

### Quick Setup API (`utils.quick_setup`)

```lua
local quick_setup = require('chalk.utils.quick_setup')

-- One-command setup
quick_setup.quick_setup(opts)              -- Setup with defaults
quick_setup.activate_for_language(lang)    -- Language-specific setup
quick_setup.setup_autocmds()               -- Setup helpful autocmds
```

### Transparency API (`utils.transparency`)

```lua
local transparency = require('chalk.utils.transparency')

transparency.enable()                      -- Enable transparency
transparency.disable()                     -- Disable transparency
transparency.toggle()                      -- Toggle state
transparency.apply_transparency()          -- Apply to specific groups
```

### Highlight Analyzer API (`utils.highlight_analyzer`)

```lua
local analyzer = require('chalk.utils.highlight_analyzer')

analyzer.list_non_transparent()            -- List groups with backgrounds
analyzer.get_non_transparent()             -- Get as table for processing
analyzer.analyze_group(name)               -- Analyze specific group
```

## 🏗️ Design Architecture

### Modular Design Philosophy

The utils system follows a **modular, lazy-loading architecture** designed for:

1. **Separation of Concerns**: Each module handles a specific domain
2. **Lazy Loading**: Modules load only when accessed to improve startup time
3. **Minimal Dependencies**: Shared utilities prevent circular dependencies
4. **Plugin Architecture**: Easy to extend with new utility modules

### Key Design Patterns

#### 1. Lazy Loading Pattern
```lua
local _modules = {}
function M.dynamic()
    if not _modules.dynamic then
        _modules.dynamic = require("chalk.utils.dynamic")
    end
    return _modules.dynamic
end
```

#### 2. Shared Utilities Pattern
```lua
-- Common functionality extracted to shared modules
local shared = require("chalk.utils.shared")
shared.notify(message, level, title)  -- Consistent notifications
shared.color_utils().adjust_brightness(color, amount)  -- Shared color math
```

#### 3. Sub-module Organization
```lua
-- Complex features split into focused sub-modules
dynamic/
├── adjustment.lua    # Color math and algorithms
├── commands.lua      # User interface (commands/keymaps)
├── interactive.lua   # Interactive functions
├── overrides.lua     # Persistence layer
└── treesitter.lua    # TreeSitter integration
```

#### 4. Configuration Override Pattern
```lua
-- Flexible configuration with sensible defaults
M.default_config = { /* defaults */ }
local config = vim.tbl_deep_extend("force", M.default_config, user_config)
```

### Module Responsibilities

| Module | Primary Responsibility | Dependencies |
|--------|----------------------|--------------|
| `init.lua` | Module coordination and lazy loading | None |
| `dynamic.lua` | Real-time color adjustment coordination | `dynamic/*`, `shared` |
| `shared/*` | Common utilities and integration | `chalk` core modules |
| `dynamic/*` | Specialized dynamic adjustment features | `shared` |
| `transparency.lua` | Transparency management | `shared` |
| `highlight_analyzer.lua` | Debug and analysis tools | `shared` |

### Data Flow Architecture

```
User Command → utils.init → Specific Module → shared utilities → chalk core
                ↓                ↓                    ↓
           Lazy Loading → Module Logic → Color Math → Apply Colors
```

## ✨ Quality Standards

### Code Quality Metrics

#### 1. **Type Safety**
- **Extensive LuaLS annotations**: All public functions have complete type annotations
- **Parameter validation**: Input validation with meaningful error messages
- **Return type consistency**: Predictable return types across similar functions

```lua
---Adjust color brightness dynamically
---@param hex string Hex color to adjust
---@param amount number Brightness adjustment (-100 to 100)
---@return string adjusted_color Adjusted hex color
function M.adjust_brightness(hex, amount)
    -- Implementation with proper validation
end
```

#### 2. **Error Handling**
- **Graceful degradation**: Failures don't break the colorscheme
- **Informative error messages**: Clear indication of what went wrong
- **Fallback mechanisms**: Safe defaults when operations fail

```lua
local ok, result = pcall(some_operation)
if not ok then
    shared.notify("Operation failed: " .. result, vim.log.levels.WARN)
    return fallback_value
end
```

#### 3. **Performance Optimization**
- **Lazy loading**: Modules load only when needed (< 1ms startup impact)
- **Caching**: Dynamic adjustments and computed colors are cached
- **Efficient algorithms**: Color math optimized for speed
- **Memory management**: Proper cleanup of temporary data

#### 4. **User Experience**
- **Consistent interface**: Similar patterns across all modules
- **Rich feedback**: Progress indicators and status messages
- **Undo/redo support**: All changes can be reverted
- **Persistent settings**: User preferences survive restarts

### Testing & Validation

#### 1. **Input Validation**
```lua
-- All user inputs are validated
if type(color) ~= "string" or not color:match("^#%x%x%x%x%x%x$") then
    error("Invalid hex color format: " .. tostring(color))
end
```

#### 2. **Boundary Testing**
- Color values validated within valid ranges (0-255 RGB, 0-360 hue)
- Configuration bounds checking (brightness adjustments within reasonable limits)
- File system operations with proper error handling

#### 3. **Compatibility Testing**
- Works across Neovim versions (0.8+)
- Terminal and GUI compatibility
- Different operating system support

### Documentation Standards

#### 1. **Inline Documentation**
- Every public function documented with LuaLS annotations
- Complex algorithms explained with comments
- Examples provided for non-obvious usage

#### 2. **API Consistency**
- Similar function signatures for related operations
- Consistent naming conventions (snake_case for functions, PascalCase for types)
- Predictable parameter ordering

#### 3. **User Documentation**
- Commands include helpful descriptions
- Error messages suggest solutions
- Examples provided for all major features

### Maintenance & Extensibility

#### 1. **Modular Architecture**
- New features can be added without modifying existing code
- Easy to disable individual features
- Clear separation between user interface and business logic

#### 2. **Configuration Management**
- All defaults centralized and easily modifiable
- User configuration properly merged with defaults
- No global state pollution

#### 3. **Backward Compatibility**
- Legacy API maintained when possible
- Deprecation warnings for removed features
- Migration guides for breaking changes

## 🔨 Usage Examples

### Quick Setup
```lua
-- Basic setup with utilities
require('chalk.utils.quick_setup').quick_setup({
    enable_dynamic = true,
    enable_transparency_commands = true,
})

-- Activate for specific use case
require('chalk.utils.quick_setup').activate_for_use_case("dynamic")
```

### Dynamic Color Adjustment
```lua
-- Setup dynamic features
require('chalk.utils').dynamic().setup_commands()

-- Use in autocmd for language-specific adjustments
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        -- Adjust Rust-specific syntax colors
        require('chalk.utils.dynamic.interactive').change_color_by_family("warm", 1)
    end
})
```

### Transparency Management
```lua
-- Toggle transparency with keymap
vim.keymap.set('n', '<leader>tt', function()
    require('chalk.utils.transparency').toggle()
end, { desc = "Toggle transparency" })
```

### Custom Color Analysis
```lua
-- Find problematic highlight groups
local analyzer = require('chalk.utils.highlight_analyzer')
local non_transparent = analyzer.get_non_transparent()

-- Process results
for _, group_info in ipairs(non_transparent) do
    local group_name, bg_color = group_info[1], group_info[2]
    print(("Group %s has background %s"):format(group_name, bg_color))
end
```

This documentation provides comprehensive coverage of the utils system, from high-level usage to implementation details, ensuring both users and developers can effectively work with the chalk.nvim utilities.
