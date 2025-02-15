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
}
