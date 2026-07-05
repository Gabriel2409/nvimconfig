return {
  'willfish/herdr-navigator.nvim',
  -- plugin forwards alt+h instead of ctrl+h
  keys = {
    {
      '<M-h>',
      function()
        require('herdr-navigator').left()
      end,
      mode = { 'n', 't' },
      desc = 'Navigate left',
    },
    {
      '<M-j>',
      function()
        require('herdr-navigator').down()
      end,
      mode = { 'n', 't' },
      desc = 'Navigate down',
    },
    {
      '<M-k>',
      function()
        require('herdr-navigator').up()
      end,
      mode = { 'n', 't' },
      desc = 'Navigate up',
    },
    {
      '<M-l>',
      function()
        require('herdr-navigator').right()
      end,
      mode = { 'n', 't' },
      desc = 'Navigate right',
    },
  },
}
