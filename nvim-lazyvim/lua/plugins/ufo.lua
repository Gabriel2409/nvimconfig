-- Investigate problem with git preview
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
local language_servers = require('lspconfig').util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
  require('lspconfig')[ls].setup {
    capabilities = capabilities,
    -- you can add other fields for setting up lsp server in this table
  }
end

-- very hacky because plugin does not expose status
-- Useful because it conflicts with gitsigns previews so we need to disable it
-- sometimes
local isUfoEnabled = true
function Toggle_Ufo()
  local Util = require 'lazy.core.util'
  if isUfoEnabled then
    require('ufo').disable()
    Util.warn('Ufo disabled', { title = 'Option' })
    -- require 'notify'('Ufo disabled', 'warn', { title = 'Options' })
  else
    require('ufo').enable()
    Util.info('Ufo enabled', { title = 'Option' })
    -- require("notify")("Ufo enabled", nil, { title = "Options" })
  end
  isUfoEnabled = not isUfoEnabled
end

return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    require('ufo').setup { fold_virt_text_handler = handler }
  end,
  keys = {
    {
      mode = { 'n' },
      '<leader>uu',
      '<cmd>lua Toggle_Ufo()<cr>',
      desc = 'Toggle Ufo ',
    },
  },
}
