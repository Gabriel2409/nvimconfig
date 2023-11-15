local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- remap jk  to escape
keymap("i", "jk", "<esc>", opts)
keymap("i", "jl", "<right>", opts)

-- remap ctrl c to yank to system clipboard
keymap("n", "<C-c>", '"+yy', { noremap = true, silent = true })
keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })
-- remap ctrl v to paste from system clipboard
-- keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
-- keymap("v", "<C-v>", '"+p', { noremap = true, silent = true })

-- remap space as leader key
keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
--vim.g.maplocalleader = "\\"

keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

-- move lines up and down
keymap("n", "<A-k>", "<cmd>m.-2<CR>", opts)
keymap("n", "<A-j>", "<cmd>m.+1<CR>", opts)

-- keep previous yank when pasting over a text in visual mode
--keymap("v", "p", '"_dP', opts)

-- ctrl s to save without formatting
keymap("n", "<c-s>", "<cmd>noautocmd w<CR>", {})
keymap("i", "<c-s>", "<esc><cmd>noautocmd w<CR>a", {})

-- ctrl z suspends vim. To see suspended jobs, run jobs. To resume vim, run fg

-- resize panes with arrow keys
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- toggle comment
keymap("n", "<C-_>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("v", "<C-_>", "<cmd>lua require('Comment.api').toggle.linewise('V')<CR>", opts)

-- tabout
vim.cmd([[inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>']])

-- Navigate
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "[b", ":bprevious<CR>", opts)
keymap("n", "]b", ":bnext<CR>", opts)

-- Add undo break-points: each time the character is added, it breaks the undo sequence
-- keymap("i", ";", ";<c-g>u", opts)
-- keymap("i", ".", ".<c-g>u", opts)
-- keymap("i", ";", ";<c-g>u", opts)

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

-- R mapping with _
vim.cmd([[let R_assign=0]])
