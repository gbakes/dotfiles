-- Disable unwanted LazyVim default plugins
return {
  -- Disable indent-blankline (causes whitespace markers)
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  
  -- Disable mini.indentscope if it's causing issues
  { "echasnovski/mini.indentscope", enabled = false },
  
  -- You can disable other unwanted plugins here by adding:
  -- { "plugin-name", enabled = false },
}