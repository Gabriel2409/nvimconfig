vim.api.nvim_set_keymap(
  'n',
  '<leader>y',
  [[:let @+ =@"<CR>]],
  { noremap = true, desc = 'Cp Unnamed Reg to System Clipboard' }
)

-- remap ctrl c to copy to system clipboard
vim.api.nvim_set_keymap('n', '<C-c>', '"+yy', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
-- -- remap ctrl v to paste from system clipboard
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })

-- ctrl s to save without formatting
vim.api.nvim_set_keymap('n', '<c-s>', '<cmd>noautocmd w<CR>', {})
vim.api.nvim_set_keymap('i', '<c-s>', '<esc><cmd>noautocmd w<CR>a', {})

-- Format
vim.api.nvim_set_keymap(
  'n',
  '<A-S-f>',
  '<cmd>lua vim.lsp.buf.format({timeout_ms = 2000})<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'i',
  '<A-S-f>',
  '<esc><cmd>lua vim.lsp.buf.format({timeout_ms = 2000})<cr>',
  { noremap = true, silent = true }
)
