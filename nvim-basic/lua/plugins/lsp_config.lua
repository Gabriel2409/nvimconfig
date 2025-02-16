return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      -- make sure to call in this order
      require('mason').setup()
      require('mason-lspconfig').setup {
        -- force install lua_ls
        ensure_installed = {
          'angularls',
          'lua_ls',
          'pyright',
          'ruff',
        },
      }
      -- can put all the lspconfig here
      require('lspconfig').angularls.setup {}
      require('lspconfig').lua_ls.setup {}
      require('lspconfig').pyright.setup {}
      require('lspconfig').ruff.setup {}
    end,
  },
}
