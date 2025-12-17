return {
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    keys = {
      { mode = { 'n' }, '<c-h>', '<cmd>TmuxNavigateLeft<cr>' },
      { mode = { 'n' }, '<c-l>', '<cmd>TmuxNavigateRight<cr>' },
      { mode = { 'n' }, '<c-j>', '<cmd>TmuxNavigateDown<cr>' },
      { mode = { 'n' }, '<c-k>', '<cmd>TmuxNavigateUp<cr>' },
    },
  },
}
