local check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

return {
  -- TAB TO AUTOCOMPLETE
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  -- then: setup supertab in cmp
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-emoji',
      'L3MON4D3/LuaSnip',
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require 'luasnip'
      local cmp = require 'cmp'

      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        -- enter should not select
        ['<CR>'] = {},

        -- tab to select current
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { select = true }
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- ['<C-k>'] = cmp.mapping.select_prev_item(),
        -- ['<C-j>'] = cmp.mapping.select_next_item(),

        -- toggle completion menu
        ['<C-Space>'] = cmp.mapping {
          i = function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end,
          c = function()
            if cmp.visible() then
              cmp.close()
            else
              cmp.complete()
            end
          end,
        },
      })
    end,
  },
}
