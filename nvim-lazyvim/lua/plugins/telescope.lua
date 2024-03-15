local actions = require 'telescope.actions'

return {
  {
    'nvim-telescope/telescope.nvim',
    opts = {
      pickers = {
        live_grep = {
          additional_args = function(opts)
            return { '--hidden', '-g', '!.git' }
          end,
        },
      },
      defaults = {
        mappings = {
          i = {
            -- ['<C-j>'] = actions.move_selection_next,
            -- ['<C-k>'] = actions.move_selection_previous,
          },
        },
      },
    },
  },
  -- add telescope-fzf-native
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension 'fzf'
      end,
    },
  },
}
