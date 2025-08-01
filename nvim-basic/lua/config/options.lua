vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- LazyVim auto format
vim.g.autoformat = true

local opt = vim.opt

opt.clipboard = '' -- use default clipboard for standard yanks
opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
opt.colorcolumn = '80,81,82,83,84,85,86,87,88' -- editor ruler (88 is black limit)
opt.formatoptions = 'jcqlnt'
opt.scrolloff = 8 -- Lines of context
opt.spelllang = { 'en' }
opt.swapfile = false
