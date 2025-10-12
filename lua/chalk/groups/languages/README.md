# Language-Specific TreeSitter Configurations

This directory contains language-specific TreeSitter highlight group definitions for chalk.nvim.

## Architecture

The language-specific configurations are organized as follows:

```
lua/chalk/groups/languages/
├── init.lua              # Language loader and manager
├── lua.lua               # Lua-specific highlights
├── python.lua            # Python-specific highlights
├── javascript.lua        # JavaScript-specific highlights
├── typescript.lua        # TypeScript-specific highlights
├── rust.lua              # Rust-specific highlights
├── go.lua                # Go-specific highlights
├── java.lua              # Java-specific highlights
├── css.lua               # CSS-specific highlights
├── html.lua              # HTML-specific highlights
├── xml.lua               # XML-specific highlights
├── json.lua              # JSON-specific highlights
├── yaml.lua              # YAML-specific highlights
├── markdown.lua          # Markdown-specific highlights
├── vim.lua               # Vim-specific highlights
├── bash.lua              # Bash/Shell-specific highlights
├── c.lua                 # C-specific highlights
├── cpp.lua               # C++-specific highlights
├── php.lua               # PHP-specific highlights
├── ruby.lua              # Ruby-specific highlights
├── sql.lua               # SQL-specific highlights
├── dockerfile.lua        # Docker-specific highlights
├── toml.lua              # TOML-specific highlights
├── gitcommit.lua         # Git commit-specific highlights
└── diff.lua              # Diff-specific highlights
```

## Usage

The main `treesitter.lua` file automatically loads all language-specific configurations:

```lua
-- Base TreeSitter highlights (language-agnostic)
local highlights = { ... }

-- Load language-specific highlights and merge them
local language_highlights = languages.load_all(colors, opts)
for group, config in pairs(language_highlights) do
    highlights[group] = config
end
```

## Adding a New Language

To add support for a new language:

1. Create a new file `{language}.lua` in this directory
2. Follow the template structure:

```lua
-- {Language} TreeSitter highlight groups for chalk.nvim
local M = {}

---Setup {Language}-specific TreeSitter highlight groups
---@param colors chalk.ColorScheme Color scheme
---@param opts chalk.Config Configuration  
---@return chalk.Highlights {Language} TreeSitter highlight groups
function M.setup(colors, opts)
    local c = colors
    
    return {
        ["@function.builtin.{language}"] = { fg = c.cyan },
        ["@keyword.function.{language}"] = { fg = c.purple },
        -- Add more language-specific highlights here
    }
end

return M
```

3. Add the language name to the `SUPPORTED_LANGUAGES` list in `init.lua`

## Language-Specific Highlight Groups

Each language file should only contain TreeSitter groups that are specific to that language (e.g., `@function.builtin.python`, `@keyword.export.javascript`, etc.).

Generic TreeSitter groups (e.g., `@function`, `@keyword`, `@string`) remain in the main `treesitter.lua` file.

## Benefits

- **Modularity**: Each language is self-contained and can be modified independently
- **Maintainability**: Easier to find and update language-specific configurations
- **Extensibility**: Simple to add new languages without cluttering the main file
- **Performance**: Only loaded when needed (though all are loaded by default currently)
- **Clarity**: Clear separation between base TreeSitter groups and language-specific overrides
