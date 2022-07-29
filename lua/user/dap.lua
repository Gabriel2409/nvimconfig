local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local ext_status_ok, dap_vscode = pcall(require, "dap.ext.vscode")
if not ext_status_ok then
	return
end

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- points to debugpy in the venv or the default installed by mason in case of failure
local venv_file = os.getenv("PWD") .. "/venv/bin/python"
local default_config_file = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
local file_to_use
if file_exists(venv_file) then
	file_to_use = venv_file
else
	file_to_use = default_config_file
end

dap.adapters.python = {
	type = "executable",
	command = file_to_use,
	args = { "-m", "debugpy.adapter" },
}
-- by default will use the .vscode/launch.json file for configurations
dap_vscode.load_launchjs(".vscode/launch.json", { debugpy = { "python" } })

local virt_status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if virt_status_ok then
	dap_virtual_text.setup()
end

local ui_status_ok, dap_ui = pcall(require, "dapui")
if ui_status_ok then
	dap_ui.setup()
end
