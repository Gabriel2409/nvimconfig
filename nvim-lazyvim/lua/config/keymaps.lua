-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local delkeymap = vim.keymap.del

-- better yank
keymap('n', 'Y', 'y$', { noremap = true, silent = true })

-- remap ctrl c to copy to system clipboard
keymap('n', '<C-c>', '"+yy', { noremap = true, silent = true })
keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
-- remap ctrl v to paste from system clipboard
keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })
keymap('v', '<C-v>', '"+p', { noremap = true, silent = true })
keymap('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })

-- ctrl s to save without formatting
keymap('n', '<c-s>', '<cmd>noautocmd w<CR>', {})
keymap('i', '<c-s>', '<esc><cmd>noautocmd w<CR>a', {})

-- Telescope
keymap(
  'n',
  '<C-p>',
  -- ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  ":lua require('telescope.builtin').find_files({find_command={'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
  { noremap = true, silent = true }
)

-- keymap(
--   "n",
--   "<C-b>",
--   ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr><esc>",
--   { noremap = true, silent = true }
-- )

-- Format
keymap('n', '<A-S-f>', '<cmd>lua vim.lsp.buf.format({timeout_ms = 2000})<cr>', { noremap = true, silent = true })
keymap('i', '<A-S-f>', '<esc><cmd>lua vim.lsp.buf.format({timeout_ms = 2000})<cr>', { noremap = true, silent = true })

-- extra surround keymaps
vim.api.nvim_set_keymap('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', 'yss', 'ys_', { noremap = false })

-- TODO
-- fix tabout
--

-- tmux integration

keymap('n', '<c-h>', '<cmd>TmuxNavigateLeft<cr>', { noremap = true, silent = true })
keymap('n', '<c-l>', '<cmd>TmuxNavigateRight<cr>', { noremap = true, silent = true })
keymap('n', '<c-j>', '<cmd>TmuxNavigateDown<cr>', { noremap = true, silent = true })
keymap('n', '<c-k>', '<cmd>TmuxNavigateUp<cr>', { noremap = true, silent = true })

-- open neotree directory for current file
keymap(
  'n',
  '<leader>E',
  '<cmd>Neotree reveal_force_cwd<cr>',
  { desc = 'Open current file dir', noremap = true, silent = true }
)

-- change directory (helps when searching with telescope within library)
vim.api.nvim_set_keymap(
  'n',
  '<leader>se',
  [[:lcd <C-r>=expand('%:h')<CR><CR>]],
  { noremap = true, desc = 'Change directory' }
)

vim.cmd [[cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%']]

-- Remove lazyvim overwriting defaults
delkeymap('n', '<S-h>')
delkeymap('n', '<S-l>')
delkeymap('n', 'n')
delkeymap('n', 'N')
