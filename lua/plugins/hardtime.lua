-- it bugs with lazyvim if we enable it directly so I only activate it after 1 sec
vim.cmd([[
  augroup HardTime
    autocmd!
    autocmd VimEnter * call timer_start(1000, { tid -> execute('lua require("hardtime").enable()')})
  augroup END
]])

return {
  -- can't seem to enable it at startup for some reason
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("hardtime").setup({ enabled = false })
    end,
    keys = {
      {
        mode = { "n" },
        "<leader>uH",
        "<cmd>lua require('hardtime').toggle()<cr>",
        desc = "Toggle Hardtime",
      },
    },
  },
}
