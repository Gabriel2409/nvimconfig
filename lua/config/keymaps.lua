-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local delkeymap = vim.keymap.del

-- remap ctrl c to copy to system clipboard
keymap("n", "<C-c>", '"+yy', { noremap = true, silent = true })
keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })
-- remap ctrl v to paste from system clipboard
keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
keymap("v", "<C-v>", '"+p', { noremap = true, silent = true })
keymap("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })

-- ctrl s to save without formatting
keymap("n", "<c-s>", "<cmd>noautocmd w<CR>", {})
keymap("i", "<c-s>", "<esc><cmd>noautocmd w<CR>a", {})

-- Telescope
keymap(
  "n",
  "<C-p>",
  ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  { noremap = true, silent = true }
)

-- keymap(
--   "n",
--   "<C-b>",
--   ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr><esc>",
--   { noremap = true, silent = true }
-- )

-- Format
keymap("n", "<A-S-f>", ":lua vim.lsp.buf.format({timeout_ms = 2000})<cr>", { noremap = true, silent = true })
keymap("i", "<esc><A-S-f>", ":lua vim.lsp.buf.format({timeout_ms = 2000})<cr>", { noremap = true, silent = true })

-- extra surround keymaps
vim.api.nvim_set_keymap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })

-- TODO
-- fix tabout
--

-- Remove lazyvim overwriting defaults
delkeymap("n", "<S-h>")
delkeymap("n", "<S-l>")
delkeymap("n", "n")
delkeymap("n", "N")
