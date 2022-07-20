local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

local ext_status_ok, dap_vscode = pcall(require, "dap.ext.vscode")
if not ext_status_ok then
  return
end

-- points to debugpy installed by mason
dap.adapters.python = {
  type = "executable",
  command = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python",
  args = { "-m", "debugpy.adapter" },
}
-- by default will use the .vscode/launch.json file for configurations
dap_vscode.load_launchjs(".vscode/launch.json", { debugpy = { "python" } })
