return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      -- point to neovim venv - for molten
      -- following dependencies are installed
      -- pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip
      vim.g.python3_host_prog = vim.fn.expand '~/.virtualenvs/neovim/bin/python3'
    end,

    keys = {
      { mode = { 'n' }, '<localleader>m', '<cmd>MoltenInit<CR>', desc = 'Molten Init' },
      { mode = { 'n' }, '<localleader>j', '<cmd>MoltenEvaluateLine<CR>', desc = 'Molten Line' },
      { mode = { 'v' }, '<localleader>j', '<cmd>MoltenEvaluateVisual<CR>gv', desc = 'Molten Visual' },
      { mode = { 'n' }, '<localleader>e', '<cmd>MoltenEvaluateOperator<CR>', desc = 'Molten Operator' },
      { mode = { 'n' }, '<localleader>rr', '<cmd>MoltenReevaluateCell<CR>', desc = 'Molten Reevaluate Cell' },
      { mode = { 'n' }, '<localleader>o', '<cmd>noautocmd MoltenEnterOutput<CR>', desc = 'Molten Enter Output' },
      { mode = { 'n' }, '<localleader>h', '<cmd>noautocmd MoltenHideOutput<CR>', desc = 'Molten Hide Output' },
      { mode = { 'n' }, '<localleader>dd', '<cmd>MoltenDelete<CR>', desc = 'Molten Delete' },
    },
  },
  {
    '3rd/image.nvim',
    opts = {
      backend = 'kitty', -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
    },
  },
  {
    'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
    },
    ft = { 'quarto', 'markdown' },
    config = function()
      local quarto = require 'quarto'
      quarto.setup {
        lspFeatures = {
          languages = { 'python' },
          chunks = 'all',
          diagnostics = {
            enabled = true,
            triggers = { 'BufWritePost' },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          -- NOTE: setup your own keymaps:
          hover = 'K',
          definition = 'gd',
          -- rename = '<leader>rn',
          -- references = 'gr',
          -- format = '<leader>gf',
        },
        codeRunner = {
          enabled = true,
          default_method = 'molten',
        },
      }
    end,
    keys = {
      {
        mode = { 'n' },
        '<localleader>rc',
        '<cmd>lua require("quarto.runner").run_cell()<CR>',
        desc = 'Quarto run cell',
      },
    },
  },
  {
    'GCBallesteros/jupytext.nvim',
    lazy = false,
    config = function()
      require('jupytext').setup {
        style = 'markdown',
        output_extension = 'md',
        force_ft = 'markdown',
      }
    end,
  },
}
