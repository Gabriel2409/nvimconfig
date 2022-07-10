local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- remap jk and jj to escape
keymap("i", "jk", "<esc>", opts)
keymap("i", "jj", "<esc>", opts)
keymap("i", "jl", "<right>", opts)

-- remap ctrl c
keymap("n", "<C-c>", '"+yy', { noremap = true, silent = true })
keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- remap space as leader key
keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
--vim.g.maplocalleader = "\\"

-- move lines up and down
keymap("n", "<A-k>", ":m.-2<CR>", opts)
keymap("n", "<A-j>", ":m.+1<CR>", opts)

-- keep previous yank when pasting over a text in visual mode
--keymap("v", "p", '"_dP', opts)

-- ctrl s to save
keymap("n", "<c-s>", ":w<CR>", {})
keymap("i", "<c-s>", "<esc>:w<CR>a", {})

-- ctrl z suspends vim. To see suspended jobs, run jobs. To resume vim, run fg
-- keymap("i", "<c-z>", "<Nop>", opts)
-- keymap("n", "<c-z>", "<Nop>", opts)
-- keymap("v", "<c-z>", "<Nop>", opts)

-- move faster
keymap("n", "<c-j>", "5j", opts)
keymap("n", "<c-k>", "5k", opts)

-- resize panes with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- toggle comment
keymap("n", "<C-_>", ":lua require('Comment.api').call('toggle_current_linewise')<cr>g@$", opts)
keymap("v", "<C-_>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)

-- stay in visual mode on indent
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- tabout
vim.cmd([[inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>']])

-- Navigate buffers
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)

-- Telescope
keymap(
  "n",
  "<C-p>",
  ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  opts
)

keymap(
  "n",
  "<C-b>",
  ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr><esc>",
  opts
)

-- Format
keymap("n", "<A-S-f>", ":lua vim.lsp.buf.format({timeout_ms = 2000})<cr>", opts)

-- Expand to active directory on tab in cmd line
vim.cmd([[cnoremap <expr>%% getcmdtype() == ':' ? expand('%:h').'/' : '%%']])

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
