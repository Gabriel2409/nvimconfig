return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- Install parsers you want
    require('nvim-treesitter').install { 'lua', 'vim', 'vimdoc', 'python', 'javascript' }

    -- Enable highlighting, folding, and indentation
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function(event)
        local ignore_filetypes = {
          'checkhealth',
          'lazy',
          'mason',
          'snacks_dashboard',
          'snacks_notif',
          'snacks_win',
        }

        if vim.tbl_contains(ignore_filetypes, event.match) then
          return
        end

        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf

        -- Start highlighting (works if parser exists)
        pcall(vim.treesitter.start, buf, lang)

        -- Enable folding
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'

        -- Enable indentation
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
