return {
  {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup()
    end,
    keys = {
      { mode = { "n" }, "<leader>oe", "<cmd>OverseerToggle<CR>", desc = "Overseer explorer" },
      { mode = { "n" }, "<leader>or", "<cmd>OverseerRun<CR>", desc = "Run task" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        mode = { "n" },
        ["<leader>o"] = { name = "+overseer" },
      },
    },
  },
}
