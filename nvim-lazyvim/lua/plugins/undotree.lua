return {
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  config = true,
  keys = { -- load the plugin only when using it's keybinding:
    { '<leader>uU', "<cmd>lua require('undotree').toggle()<cr>", desc = 'Undo toggle tree' },
  },
}
-- return {
--   {
--     'mbbill/undotree',
--     cmd = 'UndotreeToggle',
--     keys = {
--       { '<leader>uU', '<cmd>UndotreeToggle<cr>', desc = 'Undo Tree Toggle' },
--     },
--     init = function()
--       -- set layout style to 2, let g:undotree_WindowLayout = 2
--       vim.g.undotree_WindowLayout = 2
--     end,
--   },
-- }
-- return {
--   'nvim-telescope/telescope.nvim',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'debugloop/telescope-undo.nvim',
--   },
--   config = function()
--     require('telescope').setup {
--       -- the rest of your telescope config goes here
--       extensions = {
--         undo = {
--           -- telescope-undo.nvim config, see below
--         },
--         -- other extensions:
--         -- file_browser = { ... }
--       },
--     }
--     require('telescope').load_extension 'undo'
--   end,
--   keys = {
--     { '<leader>uU', '<cmd>Telescope undo<cr>', desc = 'Undo Tree Toggle' },
--   },
-- }
