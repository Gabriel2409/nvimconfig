-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Install your plugins here
lazy.setup({
	-- "nvim-lua/popup.nvim", -- Deprecated it seems
	"nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
	{
		"nvim-neo-tree/neo-tree.nvim", -- tree explorer
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- ui componenent
			"MunifTanjim/nui.nvim", -- ui component
		},
	},
	"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	"numToStr/Comment.nvim",
	-- "akinsho/bufferline.nvim", -- I don't use tabs anymore
	-- "moll/vim-bbye", -- used for Bdelete: closes the buffer without messing windows
	"nvim-lualine/lualine.nvim", -- better status line
	"akinsho/toggleterm.nvim", -- toggle terminal easily
	"ahmedkhalf/project.nvim", -- easily find recent projects
	"lukas-reineke/indent-blankline.nvim", -- show context line
	"goolord/alpha-nvim", -- better start menu
	"folke/which-key.nvim", -- lots of shortcuts
	"kylechui/nvim-surround", -- surround text
	"chentoast/marks.nvim", -- better mark display
	-- debugger
	"mfussenegger/nvim-dap",
	"theHamsta/nvim-dap-virtual-text",
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	-- to correctly parse json config in .vscode/launch.json
	{ "Joakker/lua-json5", build = "./install.sh" },
	"stevearc/overseer.nvim", -- task runner that can use vscode tasks
	"jalvesaq/Nvim-R", -- R support
	-- Colorschemes
	"lunarvim/darkplus.nvim",
	"tomasr/molokai",
	"dracula/vim",
	"sainnhe/sonokai",
	"phanviet/vim-monokai-pro",
	{ url = "https://gitlab.com/__tpb/monokai-pro.nvim" },
	"folke/tokyonight.nvim",
	"ellisonleao/gruvbox.nvim",
	--
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
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters -- Will be deprecated soon
	--
	-- diagnostics on virtual lines below text
	{ url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
	--
	-- "kevinhwang91/nvim-bqf", -- better quickfix
	-- Telescope
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	--
	"windwp/nvim-spectre", -- global search and replace
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"nvim-treesitter/nvim-treesitter-context",
	-- highlight of args
	{
		"m-demare/hlargs.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	--
	"p00f/nvim-ts-rainbow", -- config in treesiter, no longer maintained
	"JoosepAlviste/nvim-ts-context-commentstring", -- modifies behavior of comment plugin
	-- Git
	"lewis6991/gitsigns.nvim",
	-- markdown preview
	-- {
	--   "iamcco/markdown-preview.nvim",
	--   build = function()
	--     vim.fn["mkdp#util#install"]()
	--   end,
	-- },
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
	"untitled-ai/jupyter_ascending.vim",
})
