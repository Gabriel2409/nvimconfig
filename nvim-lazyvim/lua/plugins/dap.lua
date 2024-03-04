-- by default will use the .vscode/launch.json file for configurations
-- dap_vscode.json_decode = require("json5").parse

-- I can't make nvim-dap-python select the correct venv. Plus it adds a lot of configs
-- that I don't need  as I use .vscode/launch.json, so I disabled it and set the adapter
-- manually. Note that it means debugpy needs to be installed in the venv

local function file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local venv_file = os.getenv 'PWD' .. '/venv/bin/python'
local default_config_file = os.getenv 'HOME' .. '/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
local file_to_use
if file_exists(venv_file) then
  file_to_use = venv_file
else
  file_to_use = default_config_file
end

return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('dap.ext.vscode').json_decode = require('json5').parse
      require('dap.ext.vscode').load_launchjs('.vscode/launch.json', { debugpy = { 'python' } })
    end,
    dependencies = {
      { 'mfussenegger/nvim-dap-python', enabled = false },
      { 'Joakker/lua-json5', build = './install.sh' },
    },
    opts = {
      adapters = {
        python = {
          type = 'executable',
          command = file_to_use,
          args = { '-m', 'debugpy.adapter' },
        },
      },
    },
  },
}
