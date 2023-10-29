return {
  {
    "kiyoon/jupynium.nvim",
    config = function()
      -- note: i need to deactivate all the keymaps so that i can correctly create
      -- the which key group
      require("jupynium").setup({
        use_default_keybindings = false,
        textobjects = { use_default_keybindings = false },
      })
    end,
    keys = {
      {
        mode = { "n" },
        "<leader>jI",
        "<cmd>!echo using pip $(which pip) && pip install ~/.local/share/nvim/lazy/jupynium.nvim/<CR>",
        desc = "Install jupynium in venv (be sure to be in correct venv)",
      },
      {
        mode = { "n" },
        "<leader>ja",
        "<cmd>JupyniumStartAndAttachToServer<CR>",
        desc = "Start jupyter",
      },
      {
        mode = { "n" },
        "<leader>jb",
        "<cmd>JupyniumStartSync<CR>",
        desc = "Sync jupyter with nvim",
      },
      {
        mode = { "n", "x" },
        "<leader>jj",
        "<cmd>JupyniumExecuteSelectedCells<CR>",
        desc = "Jupynium execute selected cells",
      },
      {
        mode = { "n", "x" },
        "<space>jc",
        "<cmd>JupyniumClearSelectedCellsOutputs<CR>",
        desc = "Jupynium clear selected cells",
      },
      {
        mode = { "n" },
        "<space>jK",
        "<cmd>JupyniumKernelHover<cr>",
        desc = "Jupynium hover (inspect a variable)",
      },
      {
        mode = { "n", "x" },
        "<space>js",
        "<cmd>JupyniumScrollToCell<cr>",
        desc = "Jupynium scroll to cell",
      },
      {
        mode = { "n", "x" },
        "<space>jo",
        "<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>",
        desc = "Jupynium toggle selected cell output scroll",
      },
      {
        "<PageUp>",
        "<cmd>JupyniumScrollUp<cr>",
        desc = "Jupynium scroll up",
      },
      {
        "<PageDown>",
        "<cmd>JupyniumScrollDown<cr>",
        desc = "Jupynium scroll down",
      },
      {
        mode = { "n", "x", "o" },
        "[j",
        "<cmd>lua require'jupynium.textobj'.goto_previous_cell_separator()<cr>",
        desc = "Go to previous Jupynium cell",
      },
      {
        mode = { "n", "x", "o" },
        "]j",
        "<cmd>lua require'jupynium.textobj'.goto_next_cell_separator()<cr>",
        desc = "Go to next Jupynium cell",
      },
      {
        mode = { "n", "x", "o" },
        "<space>jj",
        "<cmd>lua require'jupynium.textobj'.goto_current_cell_separator()<cr>",
        desc = "Go to current Jupynium cell",
      },
      mode = {
        { "x", "o" },
        "aj",
        "<cmd>lua require'jupynium.textobj'.select_cell(true, false)<cr>",
        desc = "Select around Jupynium cell",
      },
      {
        mode = { "x", "o" },
        "ij",
        "<cmd>lua require'jupynium.textobj'.select_cell(false, false)<cr>",
        desc = "Select inside Jupynium cell",
      },
      {
        mode = { "x", "o" },
        "aJ",
        "<cmd>lua require'jupynium.textobj'.select_cell(true, true)<cr>",
        desc = "Select around Jupynium cell (include next cell separator)",
      },
      {
        mode = { "x", "o" },
        "iJ",
        "<cmd>lua require'jupynium.textobj'.select_cell(false, true)<cr>",
        desc = "Select inside Jupynium cell (include next cell separator)",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["<leader>j"] = { name = "+jupyter" },
      },
    },
  },
  {
    -- add a new cmp source
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "jupynium", priority = 1000 } }))
    end,
  },
}
