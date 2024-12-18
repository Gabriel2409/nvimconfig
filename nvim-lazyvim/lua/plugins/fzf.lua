return {
  {
    'ibhagwan/fzf-lua',
    -- config = function()
    --   require('fzf-lua').setup({ "telescope", winopts = { preview = { default = "bat" } } })
    -- end,
    keys = {
      { mode = { 'n' }, '<C-p>', "<cmd>lua require('fzf-lua').files()<CR>", desc = 'Overseer explorer' },
    }
  },
}
