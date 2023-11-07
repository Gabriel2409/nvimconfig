-- by default will use the .vscode/launch.json file for configurations
-- dap_vscode.json_decode = require("json5").parse

-- I can't make nvim-dap-python select the correct venv. Plus it adds a lot of configs
-- that I don't need  as I use .vscode/launch.json, so I disabled it and set the adapter
-- manually. Note that it means debugpy needs to be installed in the venv
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap.ext.vscode").load_launchjs(".vscode/launch.json", { debugpy = { "python" } })
      require("dap.ext.vscode").json_decode = require("json5").parse
    end,
    dependencies = {
      { "mfussenegger/nvim-dap-python", enabled = false },
      { "Joakker/lua-json5", build = "./install.sh" },
    },
    opts = {
      adapters = {
        python = {
          type = "executable",
          command = os.getenv("PWD") .. "/venv/bin/python",
          args = { "-m", "debugpy.adapter" },
        },
      },
    },
  },
}
