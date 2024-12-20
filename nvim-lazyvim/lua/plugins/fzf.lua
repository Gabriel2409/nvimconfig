return {
  {
    'ibhagwan/fzf-lua',
    -- config = function()
    --   require('fzf-lua').setup({ "telescope", winopts = { preview = { default = "bat" } } })
    -- end,
    keys = {
      { mode = { 'n' }, '<C-p>', "<cmd>lua require('fzf-lua').files()<CR>", desc = 'Overseer explorer' },
    },
    opts = {
      files = {
        actions = {
          ["ctrl-r"] = { require "fzf-lua.actions".toggle_ignore },
          ["ctrl-g"] = false,
          ["alt-i"] = false,
          ["alt-h"] = false,
        }
      },
      grep  = {
        actions = {
          ["ctrl-r"] = { require "fzf-lua.actions".toggle_ignore },
          ["alt-i"] = false,
          ["alt-h"] = false,
        }
      }

    },
  },
}
