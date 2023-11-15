-- it bugs with lazyvim if we enable it directly so I only activate it after 1 sec
-- vim.cmd([[
--   augroup HardTime
--     autocmd!
--     autocmd VimEnter * call timer_start(1000, { tid -> execute('lua require("hardtime").enable()')})
--   augroup END
-- ]])
--
-- very hacky because plugin does not expose status
local isHardtimeEnabled = true
function Toggle_hardtime()
  require("hardtime").toggle()
  local Util = require("lazy.core.util")
  if isHardtimeEnabled then
    Util.warn("Hardtime disabled", { title = "Option" })
    -- require("notify")("Hardtime disabled", "warn", { title = "Options" })
  else
    Util.info("Hardtime enabled", { title = "Option" })
    -- require("notify")("Hardtime enabled", nil, { title = "Options" })
  end
  isHardtimeEnabled = not isHardtimeEnabled
end

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
        "<cmd>lua Toggle_hardtime()<cr>",
        desc = "Toggle Hardtime",
      },
    },
  },
}
