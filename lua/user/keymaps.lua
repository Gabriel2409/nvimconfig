local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- remap jk and jj to escape
keymap('i', 'jk', '<esc>', opts)
keymap('i', 'jj', '<esc>', opts)

-- remap space as leader key
keymap("", "<Space>", "<Nop>", { noremap=true, silent=true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move lines up and down
keymap('n','<A-k>', ':m.-2<CR>', opts)
keymap('n','<A-j>', ':m.+1<CR>', opts)

-- ctrl s to save
keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<esc>:w<CR>a', {})

-- ctrl z does not close anymore
keymap("i", "<c-z>", "<Nop>", opts)
keymap("n", "<c-z>", "<Nop>", opts)
keymap("v", "<c-z>", "<Nop>", opts)
-- switch pane with ctrl hjkl
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-l>', '<c-w>l', opts)

-- stay in visual mode on indent
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


-- Resize with arrows
 -- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
 -- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
 -- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
 -- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
  keymap("n", "<S-l>", ":bnext<CR>", opts)
  keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Terminal --
-- Better terminal navigation
 -- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
 -- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
 -- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
 -- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

