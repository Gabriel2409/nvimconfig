return {
  {
    dir = vim.fn.stdpath('config') .. '/lua/dev/smartsub',
    name = 'smartsub',
    cmd = 'S',                         -- charge le plugin au premier :S
    config = function()
      require('dev.smartsub')
    end,
  },
}
