-- Example chalk.nvim configuration
-- Copy this to your plugins configuration

return {
  "your-username/chalk.nvim",
  name = "chalk",
  lazy = false,
  priority = 1000,
  config = function()
    require("chalk").setup({
      -- Theme variant: "default", "light", "oled"
      variant = "default",
      
      -- Enable transparency
      transparent = false,
      
      -- Enable terminal colors
      terminal_colors = true,
      
      -- Dim inactive windows
      dim_inactive = false,
      
      -- Style configurations
      styles = {
        comments = { italic = true },
        keywords = { bold = false, italic = false },
        functions = { bold = false, italic = false },
        variables = { italic = false },
        strings = { italic = false },
      },
      
      -- Plugin integrations (auto-detected by default)
      integrations = {
        treesitter = true,
        lsp = true,
        telescope = true,
        nvim_cmp = true,
        gitsigns = true,
        lualine = true,
        which_key = true,
        -- ... many more available
      },
    })
    
    -- Load the colorscheme
    vim.cmd.colorscheme("chalk")
  end,
}
