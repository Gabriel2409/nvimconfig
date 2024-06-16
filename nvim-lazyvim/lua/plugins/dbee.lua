return {
  {
    'kndndrj/nvim-dbee',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require('dbee').install()
    end,
    opts = {},
    keys = {
      {
        mode = { 'n' },
        '<leader>D',
        '<cmd>lua require("dbee").toggle()<CR>',
        desc = 'Toggle Dbee',
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'MattiasMTS/cmp-dbee',
        -- commit = '0feabc1',
        dependencies = {
          { 'kndndrj/nvim-dbee' },
        },
        -- ft = 'sql', -- optional but good to have
        -- opts = {}, -- needed
        config = function()
          require('cmp-dbee').setup()
        end,
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = 'cmp-dbee' })
    end,
  },
}
