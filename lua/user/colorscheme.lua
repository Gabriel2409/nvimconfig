-- local colorscheme = "monokai_pro"
local colorscheme = "sonokai"
-- local colorscheme = "tokyonight"
-- local colorscheme = "gruvbox"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

vim.cmd([[hi Matchparen guibg=#aaaaaa]]) -- set matching parenthesis bgcolor

if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found")
elseif colorscheme == "monokai_pro" then
	-- fix italic issues of windows terminal
	vim.cmd([[
        hi Identifier gui=NONE
        hi Type gui=None
    ]])

	-- change word color lsp
	vim.cmd([[
         highlight LspReferenceRead guibg=#555555
         highlight LspReferenceText guibg=#555555
         highlight LspReferenceWrite guibg=#555555
        ]])
end
