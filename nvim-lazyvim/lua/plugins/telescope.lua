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
      spec = {
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
    keys = {
      -- Telescope
      {
        mode = { 'n' },
        '<C-p>',
        -- ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "<cmd>lua require('telescope.builtin').find_files({find_command={'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
      },
      {
        mode = { 'n' },
        '<leader>p',
        '<cmd>lua require("telescope.builtin").fd({cwd = vim.fn.expand("%:p:h")})<cr>',
        desc = 'Find files current path',
      },
      {
        mode = { 'n' },
        '<leader>/',
        '<cmd>lua require("telescope.builtin").live_grep()<cr>',
        desc = 'Grep',
      },
      {
        mode = { 'n' },
        '<leader>\\',
        '<cmd>lua require("telescope.builtin").live_grep({cwd = vim.fn.expand("%:p:h")})<cr>',
        desc = 'Grep current path',
      },
    },
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension 'fzf'
      end,
    },
  },
}
