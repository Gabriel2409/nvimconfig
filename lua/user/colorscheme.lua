--local colorscheme = "monokaipro"
local colorscheme = "tokyonight"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found")
else
  -- fix italic issues of windows terminal
  -- vim.cmd([[
  --       hi Identifier gui=NONE
  --       hi Type gui=None
  --   ]])

  -- change word color lsp
  -- vim.cmd([[
  --        highlight LspReferenceRead guibg=#555555
  --        highlight LspReferenceText guibg=#555555
  --        highlight LspReferenceWrite guibg=#555555
  --       ]])
end
