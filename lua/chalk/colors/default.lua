-- Default dark theme variant for chalk.nvim
-- Warm, earthy chalk colors on dark chalkboard backgrounds

---@type chalk.Palette
return {
  -- Background colors (dark slate/chalkboard tones)
  bg_darker = "#0e1419", -- Deepest background
  bg_dark = "#1a1f24", -- Dark background
  bg = "#1e2328", -- Main background (chalkboard)
  bg_light = "#2a2f35", -- Light background
  bg_lighter = "#363c42", -- Lightest background

  -- Foreground colors (chalk white/cream tones)
  fg_darker = "#8a9199", -- Darkest foreground
  fg = "#c9c7cd", -- Main foreground (chalk white)
  fg_light = "#e6e4ea", -- Light foreground

  -- Primary colors (chalk blues and teals)
  primary = "#73b3e7", -- Soft chalk blue
  secondary = "#7fc8db", -- Chalk teal
  accent = "#8ed1c7", -- Mint chalk

  -- Status colors (vivid but not harsh)
  error = "#e06c75", -- Soft red chalk
  warning = "#e5c07b", -- Yellow chalk
  info = "#61afef", -- Info blue
  hint = "#56b6c2", -- Hint cyan
  success = "#98c379", -- Green chalk

  -- Semantic colors (warm, muted tones)
  purple = "#c678dd", -- Purple chalk
  blue = "#61afef", -- Blue chalk
  red = "#e06c75", -- Red chalk
  green = "#98c379", -- Green chalk
  orange = "#d19a66", -- Orange chalk
  yellow = "#e5c07b", -- Yellow chalk
  comment = "#5c6370", -- Muted comment
  cyan = "#56b6c2", -- Cyan chalk
  light_gray = "#abb2bf", -- Light punctuation

  -- Git colors
  git_add = "#98c379", -- Git add green
  git_change = "#e5c07b", -- Git change yellow
  git_delete = "#e06c75", -- Git delete red
  git_text = "#61afef", -- Git text blue

  -- Diff colors
  diff_add = "#98c379", -- Diff add
  diff_delete = "#e06c75", -- Diff delete
  diff_change = "#e5c07b", -- Diff change
  diff_text = "#61afef", -- Diff text

  -- Selection and UI colors
  selection = "#3e4451", -- Selection background
  search = "#e5c07b", -- Search highlight
  match = "#c678dd", -- Matching bracket
  cursor = "#528bff", -- Cursor blue
  cursor_line = "#2c323c", -- Cursor line
  line_number = "#4b5263", -- Line numbers
  line_number_current = "#abb2bf", -- Current line number

  -- Menu and completion colors
  menu_bg = "#21252b", -- Menu background
  menu_sel = "#2c323c", -- Menu selection
  menu_border = "#4b5263", -- Menu border

  -- Float and popup colors
  float_bg = "#21252b", -- Float background
  float_border = "#4b5263", -- Float border

  -- Diagnostic colors
  diagnostic_error = "#e06c75", -- Diagnostic error
  diagnostic_warning = "#e5c07b", -- Diagnostic warning
  diagnostic_info = "#61afef", -- Diagnostic info
  diagnostic_hint = "#56b6c2", -- Diagnostic hint
}
