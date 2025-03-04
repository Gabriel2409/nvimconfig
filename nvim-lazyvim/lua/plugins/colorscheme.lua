return {
  -- add gruvbox
  { 'ellisonleao/gruvbox.nvim' },
  { 'catppuccin/nvim' },
  { 'sainnhe/sonokai' },

  -- Configure LazyVim to load catpuccin
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
}
