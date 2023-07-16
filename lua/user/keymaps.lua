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

-- move lines up and down
keymap("n", "<A-k>", ":m.-2<CR>", opts)
keymap("n", "<A-j>", ":m.+1<CR>", opts)

-- keep previous yank when pasting over a text in visual mode
--keymap("v", "p", '"_dP', opts)

-- ctrl s to save without formatting
keymap("n", "<c-s>", ":noautocmd w<CR>", {})
keymap("i", "<c-s>", "<esc>:noautocmd w<CR>a", {})

-- ctrl z suspends vim. To see suspended jobs, run jobs. To resume vim, run fg

-- resize panes with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- toggle comment
keymap("n", "<C-_>", ":lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("v", "<C-_>", ":lua require('Comment.api').toggle.linewise('V')<CR>", opts)

-- tabout
vim.cmd([[inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>']])

-- Navigate buffers
-- keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
-- keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "[b", ":bprevious<CR>", opts)
keymap("n", "]b", ":bnext<CR>", opts)

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
