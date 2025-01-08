-- very hacky because plugin does not expose status
local isHardtimeEnabled = false
function Toggle_hardtime()
  require('hardtime').toggle()
  local Util = require 'lazy.core.util'
  if isHardtimeEnabled then
    Util.warn('Hardtime disabled', { title = 'Option' })
    -- require("notify")("Hardtime disabled", "warn", { title = "Options" })
  else
    Util.info('Hardtime enabled', { title = 'Option' })
    -- require("notify")("Hardtime enabled", nil, { title = "Options" })
  end
  isHardtimeEnabled = not isHardtimeEnabled
end

return {
  -- can't seem to enable it at startup for some reason
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {},
    config = function()
      require('hardtime').setup { enabled = isHardtimeEnabled }
    end,
    keys = {
      {
        mode = { 'n' },
        '<leader>uH',
        '<cmd>lua Toggle_hardtime()<cr>',
        desc = 'Toggle Hardtime',
      },
    },
  },
}
