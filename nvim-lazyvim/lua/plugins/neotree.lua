return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
        },
      },
    },
    window = {
      position = "left",
      mappings = {
        ["h"] = "close_node",
        ["l"] = "open",
      },
    },
  },
}
