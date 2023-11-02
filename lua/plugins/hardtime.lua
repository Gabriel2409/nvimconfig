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
