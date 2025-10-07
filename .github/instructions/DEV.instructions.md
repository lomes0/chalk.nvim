---
applyTo: '**'
---
# Modern Neovim Colorscheme Development Instructions

## Project Overview

This document outlines the development plan for creating a modern, treesitter-focused Neovim colorscheme that combines the best architectural patterns and design concepts from three exemplary colorschemes:

- **kanagawa-paper.nvim**: Sophisticated architecture with theme variants, color manipulation utilities, and extensive plugin integrations
- **oh-lucy.nvim**: Clean, simple structure with effective color organization and treesitter support
- **oldworld.nvim**: Modular design with variant system and clean configuration approach

## Architecture Design

### 1. Project Structure

```
colorscheme-name.nvim/
├── README.md
├── LICENSE
├── colors/
│   └── colorscheme-name.vim          # Legacy vim colorscheme file
├── lua/
│   └── colorscheme-name/
│       ├── init.lua                  # Main entry point
│       ├── config.lua                # Configuration management
│       ├── colors.lua                # Color palette and theme definitions
│       ├── utils/
│       │   ├── color.lua             # Color manipulation utilities
│       │   └── helpers.lua           # Helper functions
│       ├── groups/
│       │   ├── init.lua              # Highlight group coordinator
│       │   ├── editor.lua            # Editor UI highlights
│       │   ├── syntax.lua            # Basic syntax highlights
│       │   ├── treesitter.lua        # Treesitter-specific highlights
│       │   └── integrations/         # Plugin-specific highlights
│       │       ├── init.lua
│       │       ├── telescope.lua
│       │       ├── nvim-cmp.lua
│       │       └── ...
│       └── themes/
│           ├── default.lua           # Default dark theme
│           ├── light.lua             # Light variant
│           └── variants.lua          # Theme variant manager
└── extras/                           # Terminal and external app configs
    ├── alacritty/
    ├── kitty/
    └── ...
```

### 2. Core Components

#### A. Color System Architecture
**Best Practice from kanagawa-paper**: Advanced color manipulation with brightness/saturation adjustments
**Best Practice from oh-lucy**: Clean, semantic color naming
**Best Practice from oldworld**: Variant-based palette system

```lua
-- colors.lua structure
local M = {}

-- Base palette (semantic colors)
M.palette = {
    -- Neutrals
    bg_darker = "#0f0f0f",
    bg_dark = "#161617",
    bg = "#1a1a1a",
    bg_light = "#2a2a2a",
    bg_lighter = "#3a3a3a",
    
    fg_darker = "#a0a0a0",
    fg = "#c9c7cd",
    fg_light = "#e0e0e0",
    
    -- Semantic colors
    primary = "#7aa2f7",
    secondary = "#bb9af7",
    accent = "#73daca",
    
    -- Status colors
    error = "#f7768e",
    warning = "#e0af68",
    info = "#7aa2f7",
    hint = "#1abc9c",
    success = "#9ece6a",
    
    -- Syntax colors
    keyword = "#bb9af7",
    function_name = "#7aa2f7",
    variable = "#c0caf5",
    string = "#9ece6a",
    number = "#ff9e64",
    boolean = "#ff9e64",
    constant = "#ff9e64",
    comment = "#565f89",
    operator = "#89b4fa",
    punctuation = "#9ca3af",
}

-- Theme variants
M.themes = {
    default = function(palette) return ... end,
    light = function(palette) return ... end,
    oled = function(palette) return ... end,
}
```

#### B. Configuration System
**Best Practice from kanagawa-paper**: Comprehensive configuration with style overrides
**Best Practice from oldworld**: Clean integration toggles
**Best Practice from oh-lucy**: Simple vim.g variable support

```lua
-- config.lua
local M = {}

M.defaults = {
    -- Theme variant
    variant = "default", -- "default", "light", "oled"
    
    -- Visual options
    transparent = false,
    terminal_colors = true,
    dim_inactive = false,
    
    -- Style configurations
    styles = {
        comments = { italic = true },
        keywords = { bold = false, italic = false },
        functions = { bold = false, italic = false },
        variables = { italic = false },
        strings = { italic = false },
        booleans = { bold = false, italic = false },
    },
    
    -- Color adjustments
    color_adjustments = {
        brightness = 0, -- -1 to 1
        contrast = 0,   -- -1 to 1
        saturation = 0, -- -1 to 1
    },
    
    -- Plugin integrations
    integrations = {
        -- Core
        treesitter = true,
        
        -- Popular plugins
        telescope = true,
        nvim_cmp = true,
        gitsigns = true,
        nvim_tree = true,
        lualine = true,
        bufferline = true,
        indent_blankline = true,
        alpha = true,
        dashboard = true,
        which_key = true,
        notify = true,
        noice = true,
        
        -- LSP related
        lsp_saga = true,
        trouble = true,
        
        -- Git
        neogit = true,
        diffview = true,
        
        -- Additional
        hop = true,
        leap = true,
        flash = true,
        mini = true,
    },
    
    -- Custom overrides
    custom_highlights = {},
    
    -- Cache for performance
    cache = true,
}
```

#### C. Treesitter Integration
**Best Practice from kanagawa-paper**: Comprehensive treesitter coverage with semantic naming
**Best Practice from oh-lucy**: Clear treesitter group organization

```lua
-- groups/treesitter.lua
local M = {}

function M.setup(colors, config)
    local theme = colors.theme
    local styles = config.styles
    
    return {
        -- Identifiers
        ["@variable"] = { fg = theme.variable },
        ["@variable.builtin"] = { fg = theme.keyword, italic = true },
        ["@variable.parameter"] = { fg = theme.parameter },
        ["@variable.member"] = { fg = theme.property },
        
        -- Literals
        ["@string"] = vim.tbl_extend("force", { fg = theme.string }, styles.strings),
        ["@string.documentation"] = { fg = theme.comment, italic = true },
        ["@string.regexp"] = { fg = theme.regex },
        ["@string.escape"] = { fg = theme.escape, bold = true },
        
        ["@character"] = { fg = theme.string },
        ["@character.special"] = { fg = theme.escape },
        
        ["@boolean"] = vim.tbl_extend("force", { fg = theme.boolean }, styles.booleans),
        ["@number"] = { fg = theme.number },
        ["@number.float"] = { fg = theme.number },
        
        -- Types
        ["@type"] = { fg = theme.type },
        ["@type.builtin"] = { fg = theme.keyword },
        ["@type.definition"] = { fg = theme.type },
        
        -- Attributes
        ["@attribute"] = { fg = theme.attribute },
        ["@attribute.builtin"] = { fg = theme.keyword },
        
        -- Functions
        ["@function"] = vim.tbl_extend("force", { fg = theme.function_name }, styles.functions),
        ["@function.builtin"] = { fg = theme.function_builtin },
        ["@function.call"] = { fg = theme.function_name },
        ["@function.macro"] = { fg = theme.macro },
        
        ["@function.method"] = { fg = theme.method },
        ["@function.method.call"] = { fg = theme.method },
        
        ["@constructor"] = { fg = theme.constructor },
        
        -- Keywords
        ["@keyword"] = vim.tbl_extend("force", { fg = theme.keyword }, styles.keywords),
        ["@keyword.coroutine"] = { fg = theme.keyword },
        ["@keyword.function"] = { fg = theme.keyword },
        ["@keyword.operator"] = { fg = theme.operator, bold = true },
        ["@keyword.import"] = { fg = theme.include },
        ["@keyword.type"] = { fg = theme.keyword },
        ["@keyword.modifier"] = { fg = theme.keyword },
        ["@keyword.repeat"] = { fg = theme.keyword },
        ["@keyword.return"] = { fg = theme.keyword, bold = true },
        ["@keyword.debug"] = { fg = theme.keyword },
        ["@keyword.exception"] = { fg = theme.keyword },
        ["@keyword.conditional"] = { fg = theme.conditional },
        ["@keyword.conditional.ternary"] = { fg = theme.operator },
        ["@keyword.directive"] = { fg = theme.preproc },
        ["@keyword.directive.define"] = { fg = theme.define },
        
        -- Operators
        ["@operator"] = { fg = theme.operator },
        
        -- Punctuation
        ["@punctuation.delimiter"] = { fg = theme.punctuation },
        ["@punctuation.bracket"] = { fg = theme.punctuation },
        ["@punctuation.special"] = { fg = theme.special },
        
        -- Comments
        ["@comment"] = vim.tbl_extend("force", { fg = theme.comment }, styles.comments),
        ["@comment.documentation"] = { fg = theme.comment, italic = true },
        ["@comment.error"] = { fg = theme.bg, bg = theme.error, bold = true },
        ["@comment.warning"] = { fg = theme.bg, bg = theme.warning, bold = true },
        ["@comment.todo"] = { fg = theme.bg, bg = theme.info, bold = true },
        ["@comment.note"] = { fg = theme.bg, bg = theme.hint, bold = true },
        
        -- Markup (for markdown, etc.)
        ["@markup.strong"] = { bold = true },
        ["@markup.italic"] = { italic = true },
        ["@markup.strikethrough"] = { strikethrough = true },
        ["@markup.underline"] = { underline = true },
        
        ["@markup.heading"] = { fg = theme.keyword, bold = true },
        ["@markup.heading.1"] = { fg = theme.keyword, bold = true },
        ["@markup.heading.2"] = { fg = theme.function_name, bold = true },
        ["@markup.heading.3"] = { fg = theme.string, bold = true },
        ["@markup.heading.4"] = { fg = theme.constant, bold = true },
        ["@markup.heading.5"] = { fg = theme.variable, bold = true },
        ["@markup.heading.6"] = { fg = theme.comment, bold = true },
        
        ["@markup.quote"] = { fg = theme.comment, italic = true },
        ["@markup.math"] = { fg = theme.number },
        
        ["@markup.link"] = { fg = theme.info, underline = true },
        ["@markup.link.label"] = { fg = theme.string },
        ["@markup.link.url"] = { fg = theme.info, italic = true, underline = true },
        
        ["@markup.raw"] = { fg = theme.string },
        ["@markup.raw.block"] = { fg = theme.string },
        
        ["@markup.list"] = { fg = theme.keyword },
        ["@markup.list.checked"] = { fg = theme.success },
        ["@markup.list.unchecked"] = { fg = theme.comment },
        
        -- Tags (for HTML, XML, etc.)
        ["@tag"] = { fg = theme.keyword },
        ["@tag.attribute"] = { fg = theme.attribute },
        ["@tag.delimiter"] = { fg = theme.punctuation },
        
        -- Language-specific
        ["@property.css"] = { fg = theme.property },
        ["@property.json"] = { fg = theme.string },
        
        -- Diff
        ["@diff.plus"] = { fg = theme.success },
        ["@diff.minus"] = { fg = theme.error },
        ["@diff.delta"] = { fg = theme.warning },
    }
end

return M
```

## Implementation Steps

### Phase 1: Core Foundation (Days 1-3)

1. **Project Setup**
   - Create directory structure
   - Set up basic configuration system
   - Implement color palette system
   - Create theme variant manager

2. **Basic Color System**
   - Define base palette with semantic naming
   - Implement color manipulation utilities (brightness, saturation, contrast)
   - Create theme generation functions
   - Set up variant system (default, light, oled)

3. **Core Highlight Groups**
   - Implement editor highlights (UI elements)
   - Set up basic syntax highlighting
   - Create fundamental treesitter groups

### Phase 2: Treesitter Integration (Days 4-6)

1. **Comprehensive Treesitter Support**
   - Implement all modern treesitter capture groups
   - Focus on semantic accuracy over LSP dependency
   - Add language-specific optimizations
   - Test with multiple file types

2. **Syntax Refinement**
   - Fine-tune color relationships
   - Ensure proper contrast ratios
   - Optimize for different background variants
   - Add markup language support

### Phase 3: Plugin Integrations (Days 7-10)

1. **Core Plugin Support**
   - telescope.nvim
   - nvim-cmp
   - gitsigns.nvim
   - nvim-tree.lua / neo-tree.nvim
   - lualine.nvim
   - bufferline.nvim

2. **Additional Integrations**
   - indent-blankline.nvim
   - which-key.nvim
   - alpha-nvim / dashboard-nvim
   - notify.nvim / noice.nvim
   - trouble.nvim
   - hop.nvim / leap.nvim / flash.nvim

### Phase 4: Polish and Extras (Days 11-14)

1. **Terminal Integration**
   - Generate terminal color schemes
   - Create external app configurations (Alacritty, Kitty, etc.)
   - Set up automatic export system

2. **Performance and Caching**
   - Implement highlight caching system
   - Optimize loading performance
   - Add lazy loading for plugin integrations

3. **Documentation and Testing**
   - Create comprehensive README
   - Add configuration examples
   - Test across different Neovim versions
   - Create screenshot gallery

## Key Design Principles

### 1. Semantic Color Organization
- Use meaningful color names rather than arbitrary variables
- Group related colors logically
- Maintain consistent color relationships across variants

### 2. Treesitter-First Approach
- Prioritize treesitter highlights over traditional syntax
- Use semantic treesitter groups for accurate highlighting
- Ensure compatibility with both treesitter and legacy syntax

### 3. Modular Architecture
- Separate concerns into focused modules
- Make plugin integrations optional and toggleable
- Allow easy customization and extension

### 4. Performance Optimization
- Implement caching for highlight generation
- Lazy load plugin integrations
- Minimize startup impact

### 5. User Experience
- Provide sensible defaults
- Make customization straightforward
- Support both simple and advanced configurations

## Color Theory Guidelines

### Contrast and Accessibility
- Ensure WCAG AA compliance for text readability
- Maintain sufficient contrast between foreground and background
- Test with different lighting conditions

### Color Harmony
- Use a consistent color temperature across the theme
- Apply complementary colors for highlighting important elements
- Maintain visual hierarchy through color intensity

### Semantic Consistency
- Use consistent colors for similar semantic elements
- Apply color psychology principles (red for errors, green for success)
- Maintain consistency across different contexts

## Advanced Features

### 1. Dynamic Color Adjustment
```lua
-- Implement brightness/saturation/contrast controls
local function adjust_color(color, adjustments)
    local c = Color:from_hex(color)
    if adjustments.brightness ~= 0 then
        c = c:brighten(adjustments.brightness)
    end
    if adjustments.saturation ~= 0 then
        c = c:saturate(adjustments.saturation)
    end
    if adjustments.contrast ~= 0 then
        c = c:adjust_contrast(adjustments.contrast)
    end
    return c:to_hex()
end
```

### 2. Automatic Theme Detection
```lua
-- Detect terminal capabilities and adjust accordingly
local function detect_capabilities()
    local term = os.getenv("TERM") or ""
    local colorterm = os.getenv("COLORTERM") or ""
    
    return {
        truecolor = vim.fn.has("termguicolors") == 1,
        term_program = os.getenv("TERM_PROGRAM"),
        supports_italics = not vim.tbl_contains({"screen", "tmux"}, term:match("^[^-]*")),
    }
end
```

### 3. Integration Auto-Detection
```lua
-- Automatically enable integrations based on available plugins
local function detect_plugins()
    local plugins = {}
    local ok, lazy = pcall(require, "lazy")
    if ok then
        -- Use lazy.nvim plugin list
        for name, _ in pairs(lazy.plugins()) do
            plugins[name] = true
        end
    else
        -- Fallback to checking if modules can be required
        local plugin_checks = {
            telescope = "telescope",
            nvim_cmp = "cmp",
            gitsigns = "gitsigns",
            -- ... more plugins
        }
        for key, module in pairs(plugin_checks) do
            plugins[key] = pcall(require, module)
        end
    end
    return plugins
end
```

## Testing Strategy

### 1. File Type Coverage
Test highlighting across various file types:
- Programming languages: Lua, Python, JavaScript, TypeScript, Go, Rust, C++
- Markup: Markdown, HTML, XML, JSON, YAML
- Configuration: Vim script, Shell scripts, Dockerfiles
- Documentation: Help files, man pages

### 2. Plugin Compatibility
- Test with popular plugin combinations
- Verify highlight precedence and conflicts
- Ensure graceful degradation when plugins are missing

### 3. Performance Benchmarks
- Measure colorscheme loading time
- Test with large files and complex syntax
- Monitor memory usage with caching enabled

## Maintenance and Updates

### 1. Version Management
- Use semantic versioning
- Maintain changelog
- Provide migration guides for breaking changes

### 2. Community Integration
- Set up issue templates
- Create contribution guidelines
- Maintain plugin integration requests

### 3. Continuous Improvement
- Regular color palette refinements
- New plugin integration additions
- Performance optimizations
- User feedback incorporation

## Conclusion

This development plan creates a modern, comprehensive Neovim colorscheme that combines the best architectural patterns from proven themes while focusing on treesitter integration and user customization. The modular design ensures maintainability and extensibility, while the comprehensive configuration system provides flexibility for various user preferences and use cases.

The resulting colorscheme should provide excellent out-of-the-box experience while remaining highly customizable and performant across different environments and plugin configurations.
