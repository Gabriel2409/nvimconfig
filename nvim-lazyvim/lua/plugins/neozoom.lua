return {
  'nyngwang/NeoZoom.lua',
  config = function()
    require('neo-zoom').setup {
      popup = { enabled = true }, -- this is the default.
      exclude_buftypes = { 'terminal' },
      -- exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf' },
      winopts = {
        offset = {
          width = 150,
          height = 0.85,
        },
        border = 'thicc', -- this is a preset, try it :)
      },
      presets = {
        {
          filetypes = { 'dapui_.*', 'dap-repl' },
          winopts = {
            offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
          },
        },
        {
          filetypes = { 'markdown' },
          callbacks = {
            function()
              vim.wo.wrap = true
            end,
          },
        },
      },
    }
    vim.keymap.set('n', '<leader>z', '<cmd>NeoZoomToggle<cr>', { silent = true, nowait = true, desc = 'Toggle Zoom' })
  end,
}
