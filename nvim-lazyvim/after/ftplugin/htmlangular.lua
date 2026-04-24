-- fix for angular html template, use treesitter
vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt_local.foldlevel = 99
