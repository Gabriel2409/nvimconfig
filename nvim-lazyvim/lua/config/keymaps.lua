-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local delkeymap = vim.keymap.del

-- copy content of unnamed register to system clipboard
vim.api.nvim_set_keymap(
  'n',
  '<leader>y',
  [[:let @+ =@"<CR>]],
  { noremap = true, desc = 'Cp Unnamed Reg to System Clipboard' }
)

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

-- ctrl p to find files
keymap('n', '<c-p>', '<cmd>lua Snacks.picker.files()<CR>', {})

-- Format
keymap('n', '<A-S-f>', '<cmd>lua vim.lsp.buf.format({timeout_ms = 2000})<cr>', { noremap = true, silent = true })
keymap('i', '<A-S-f>', '<esc><cmd>lua vim.lsp.buf.format({timeout_ms = 2000})<cr>', { noremap = true, silent = true })

-- extra surround keymaps
vim.api.nvim_set_keymap('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', 'yss', 'ys_', { noremap = false })

-- TODO
-- fix tabout

-- search in current dir, useful when digging in libraries or venv
vim.api.nvim_set_keymap(
  'n',
  '<leader>fL',
  "<cmd>lua Snacks.picker.files({dirs={vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')}, hidden=true, ignored=true})<cr>",
  { noremap = true, desc = 'Find files in currently selected dir' }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>sL',
  "<cmd>lua Snacks.picker.grep({dirs={vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')}, hidden=true, ignored=true})<cr>",
  { noremap = true, desc = 'Grep in currently selected dir' }
)

vim.cmd [[cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%']]

-- Remove lazyvim overwriting defaults
delkeymap('n', '<S-h>')
delkeymap('n', '<S-l>')
delkeymap('n', 'n')
delkeymap('n', 'N')

-- experiments
keymap('n', '<S-l>', '$', {})
keymap('v', '<S-l>', '$', {})
keymap('n', '<S-h>', '^', {})
keymap('v', '<S-h>', '^', {})

vim.api.nvim_set_keymap(
  'n',
  '<leader>"',
  '<cmd>lua Snacks.picker.registers()<cr>',
  { noremap = true, desc = 'Registers' }
)

-- dap keymaps
vim.api.nvim_set_keymap(
  'n',
  '<localleader>b',
  '<cmd>lua require("dap").toggle_breakpoint()<cr>',
  { noremap = true, desc = 'toggle breakpoint' }
)
vim.api.nvim_set_keymap(
  'n',
  '<localleader>c',
  '<cmd>lua require("dap").continue()<cr>',
  { noremap = true, desc = 'dap continue' }
)
vim.api.nvim_set_keymap(
  'n',
  '<localleader>s',
  '<cmd>lua require("dap").step_over()<cr>',
  { noremap = true, desc = 'dap step over' }
)

-- zoom keymaps
vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>lua Snacks.zen.zen()<cr>', { noremap = true, desc = 'zen mode' })
vim.api.nvim_set_keymap('n', '<c-w>z', '<cmd>lua Snacks.zen.zen()<cr>', { noremap = true, desc = 'zen mode' })

-- toggle breakpoint on click instead of fold

-- vim.keymap.set('n', '<LeftMouse>', function()
--   local mouse_pos = vim.fn.getmousepos()
--   if mouse_pos.column <= 1
--     local current_pos = vim.api.nvim_win_get_cursor(0)
--
--     vim.api.nvim_win_set_cursor(0,{mouse_pos.line, current_pos[2]})
--     require('dap').toggle_breakpoint()
--     return true
--   else
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<LeftMouse>', true, false, true), 'n', false)
--   end
-- end, {})

-- macros
-- add equal sign with current element next to it
vim.fn.setreg('e', ':s/\\([^ \\n\\t].*\\)/\\1=\\1\nj')
