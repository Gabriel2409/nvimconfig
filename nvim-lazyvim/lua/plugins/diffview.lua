return {
  -- opens diffview in a new tab.
  -- use tabclose to remove it
  'sindrets/diffview.nvim',
  keys = {
    {
      mode = { 'n' },
      '<leader>gv',
      function()
        local arg = vim.fn.input 'DiffviewOpen'
        if arg ~= '' then
          vim.cmd('DiffviewOpen ' .. arg)
        else
          vim.cmd 'DiffviewOpen'
        end
      end,
      desc = 'DiffviewOpen with prompt',
    },
  },
}
