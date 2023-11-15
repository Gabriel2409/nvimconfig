-- Example to get an option
-- :lua print(vim.opt.swapfile:get())

local options = {
	backup = false, -- creates a backup file
	--clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	colorcolumn = "80,81,82,83,84,85,86,87,88", -- editor ruler (88 is black limit)
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	cursorline = true, -- highlight the current line
	expandtab = true, -- convert tabs to spaces
	fileencoding = "utf-8", -- the encoding written to a file
	formatoptions = "jcroqlnt", -- various formatting behaviors
	grepformat = "%f:%l:%c:%m",
	grepprg = "rg --vimgrep",
	guifont = "monospace:h17", -- the font used in graphical neovim applications
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	laststatus = 3, -- global statusline always visible
	list = true, -- show some invisible chars
	mouse = "a", -- allow the mouse to be used in neovim
	number = true, -- set numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	pumblend = 10, -- partially transparent popup
	pumheight = 10, -- pop up menu height
	relativenumber = true, -- set relative numbered lines
	scrolloff = 8, -- lines of context
	sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	showmode = false, --  no need, we have a status line
	showtabline = 2, -- always show tabs
	sidescrolloff = 8,
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	spelllang = { "en" },
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	tabstop = 2, -- insert 2 spaces for a tab
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 200, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	undolevels = 10000,
	updatetime = 300, -- faster completion (4000ms default)
	virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
	wildmode = "longest:full,full", -- Command-line completion mode
	wrap = true, -- wrap a long line
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

for k, v in pairs(options) do
	vim.opt[k] = v
end
