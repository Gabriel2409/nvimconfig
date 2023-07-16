-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)
-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup lazy_user_config
    autocmd!
    autocmd BufWritePost plugins.lua | Lazy sync
  augroup end
]])

-- Install your plugins here
lazy.setup({
	-- Plugins required by a lot of plugins
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
	-- lua plugin development
	"folke/neodev.nvim",
	-- tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	-- "terrortylor/nvim-comment", -- Easily comment stuff
	"numToStr/Comment.nvim",
	"akinsho/bufferline.nvim",
	"moll/vim-bbye", -- used for Bdelete: closes the buffer without messing windows
	"nvim-lualine/lualine.nvim",
	"akinsho/toggleterm.nvim",
	"ahmedkhalf/project.nvim",
	"lewis6991/impatient.nvim",
	"lukas-reineke/indent-blankline.nvim", -- show context line
	"goolord/alpha-nvim",
	"folke/which-key.nvim",
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	-- marks
	"chentoast/marks.nvim",
	-- debugger
	"mfussenegger/nvim-dap",
	"theHamsta/nvim-dap-virtual-text",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	-- tasks
	"stevearc/overseer.nvim",
	--R
	"jalvesaq/Nvim-R",
	-- Colorschemes
	"lunarvim/darkplus.nvim",
	"tomasr/molokai",
	"dracula/vim",
	"sainnhe/sonokai",
	"phanviet/vim-monokai-pro",
	{ url = "https://gitlab.com/__tpb/monokai-pro.nvim" },
	"folke/tokyonight.nvim",
	"ellisonleao/gruvbox.nvim",
	-- cmp plugins
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
		},
	},
	-- LSP
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Useful status updates for LSP
			"j-hui/fidget.nvim",
		},
	},
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
	-- diagnostics on virtual lines below text
	-- {
	-- 	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	-- 	end,
	-- },

	-- better quickfix
	"kevinhwang91/nvim-bqf",
	-- highlight of args
	{
		"m-demare/hlargs.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	-- Telescope
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	-- Spectre
	"windwp/nvim-spectre",
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"nvim-treesitter/nvim-treesitter-context",
	"p00f/nvim-ts-rainbow", -- config in treesiter
	"JoosepAlviste/nvim-ts-context-commentstring", -- modifies behavior of comment plugin
	-- Git
	"lewis6991/gitsigns.nvim",
	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- {
	-- 	"tpope/vim-dadbod",
	-- 	dependencies = { "kristijanhusak/vim-dadbod-ui", "kristijanhusak/vim-dadbod-completion" },
	-- },
	-- {
	-- 	"ellisonleao/dotenv.nvim",
	-- 	config = function()
	-- 		require("dotenv").setup({})
	-- 	end,
	-- },
})
