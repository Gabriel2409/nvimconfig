-- in godot, editor -> external
-- Exec Path: nvim
-- Exec flags:  --headless --server /tmp/godot.nvim.pipe  --remote-send "<esc>:n {file}<CR>:call cursor({line},{col})<CR>"

-- then we can start neovim with
-- nvim --listen /tmp/godot.nvim.pipe
-- or even better, launch the serverstart ourselves

function ToggleGodotServer()
  local pipe_path = '/tmp/godot.nvim.pipe'

  -- Check if the server pipe file exists
  if vim.fn.filereadable(pipe_path) == 1 then
    -- If the server is running, stop it (remove the pipe file)
    vim.fn.system('rm ' .. pipe_path)
    print 'Godot server stopped.'
  else
    -- If the server is not running, start it
    vim.fn.serverstart(pipe_path)
    print 'Godot server started.'
  end
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'gdscript', 'gdshader', 'godot_resource' } },
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'gdtoolkit' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gdscript = {},
      },
    },
    keys = {
      {
        mode = { 'n' },
        '<leader>G',
        '<cmd>lua ToggleGodotServer()<cr>',
        desc = 'Start godot server',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        gdscript = { 'gdformat' },
      },
    },
  },
}

--- NOTE: basic plugin to toggle editor in gdscript
-- @tool
-- extends EditorPlugin
--
--
-- func _enter_tree() -> void:
-- 	var command_palette = EditorInterface.get_command_palette()
-- 	command_palette.add_command(
-- 		"Toggle External Editor", "toggle_external_editor/toggle", toggle_external_editor
-- 	)
--
--
-- func _exit_tree() -> void:
-- 	var command_palette = EditorInterface.get_command_palette()
-- 	command_palette.remove_command("toggle_external_editor/toggle")
--
--
-- func toggle_external_editor():
-- 	var settings = EditorInterface.get_editor_settings()
-- 	var prop = "text_editor/external/use_external_editor"
-- 	var current_value = settings.get_setting(prop)
-- 	var new_value = not current_value
-- 	settings.set_setting(prop, new_value)
-- 	if new_value:
-- 		print("External Editor enabled")
-- 	else:
-- 		print("External Editor disabled")
