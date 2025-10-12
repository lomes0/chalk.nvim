-- Example configuration for chalk.nvim
-- Updated for the new TokyoNight-style architecture

return {
  -- Theme variants
  variant = "default", -- "default", "light", "oled"
  light_variant = "light", -- variant to use when vim.o.background = "light"

  -- Visual options
  transparent = false,
  terminal_colors = true,
  dim_inactive = false, -- dim inactive windows

  -- Performance
  cache = true, -- enable caching for better performance

  -- Style configurations for syntax elements
  styles = {
    comments = { italic = true },
    keywords = { bold = false, italic = false },
    functions = { bold = false, italic = false },
    variables = { italic = false },
    strings = { italic = false },
    types = { bold = false, italic = false },
    constants = { bold = false },
    operators = { bold = false },
  },

  -- Plugin integrations with auto-detection
  plugins = {
    -- Enable all detected plugins by default
    all = true,
    -- Auto-detect available plugins
    auto = true,
    
    -- Individual plugin controls (override auto-detection)
    treesitter = true,
    telescope = true,
    nvim_cmp = true,
    gitsigns = true,
    lualine = true,
    which_key = true,
    indent_blankline = true,
    nvim_tree = true,
    neo_tree = true,
    bufferline = true,
    dashboard = true,
    alpha = true,
    noice = true,
    notify = true,
    mini = true,
    leap = true,
    flash = true,
    navic = true,
    aerial = true,
  },

  -- Callback functions
  ---@param colors chalk.ColorScheme
  on_colors = function(colors)
    -- Modify colors here if needed
    -- colors.primary = "#ff0000" -- Example: change primary color
    -- colors.comment = "#666666" -- Example: change comment color
  end,

  ---@param highlights chalk.Highlights
  ---@param colors chalk.ColorScheme  
  on_highlights = function(highlights, colors)
    -- Modify highlight groups here if needed
    -- highlights.Normal = { fg = colors.fg, bg = colors.bg }
    -- highlights.Comment = { fg = colors.comment, italic = true }
  end,
}

-- Example usage in your Neovim config:
--[[
-- Using lazy.nvim
{
  "your-username/chalk.nvim", 
  priority = 1000,
  config = function()
    require("chalk").setup({
      variant = "default",
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { bold = true },
      },
      on_colors = function(colors)
        colors.comment = "#8a9199" -- Custom comment color
      end,
    })
    vim.cmd.colorscheme("chalk")
  end,
}

-- Manual setup
require("chalk").setup({
  variant = "oled", -- for OLED displays
  transparent = true,
})
vim.cmd.colorscheme("chalk")

-- Toggle between light and dark
vim.keymap.set("n", "<leader>tt", function() require("chalk").toggle() end, { desc = "Toggle theme" })

-- Preview different variants
local colors = require("chalk").preview("light")
print(vim.inspect(colors))
--]]
