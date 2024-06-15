return {
  -- TODO: CHECK IF OFFICIAL GETS BETTER
  -- 'ThePrimeagen/git-worktree.nvim', -- original
  --'polarmutex/git-worktree.nvim', -- preferred fork?
  'awerebea/git-worktree.nvim',
  branch = 'handle_changes_in_telescope_api',

  config = function()
    -- note: i need to deactivate all the keymaps so that i can correctly create
    -- the which key group
    require('git-worktree').setup()
    require('telescope').load_extension 'git_worktree'
  end,
  keys = {
    {
      mode = { 'n' },
      '<leader>gw',
      "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      desc = 'Git worktree- list',
    },
    {
      mode = { 'n' },
      '<leader>gW',
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      desc = 'Git worktree - create',
    },
  },
}
