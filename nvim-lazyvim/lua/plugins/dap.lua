return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('dap.ext.vscode').json_decode = require('json5').parse
    end,
    dependencies = {
      { 'Joakker/lua-json5', build = './install.sh' },
      {
        'mfussenegger/nvim-dap-python',
        config = function()
          -- Uses current python (works with virtual envs)
          -- NOTE: you need to manually install debugpy in each venv,
          -- contrary to vscode that uses a bundled unique debugpy
          require("dap-python").setup("python")
        end
      },
    },
  },
}
