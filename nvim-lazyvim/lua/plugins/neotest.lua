local float_win = nil
local open_summary_in_floating_window = function()
  if float_win and vim.api.nvim_win_is_valid(float_win) then
    vim.api.nvim_set_current_win(float_win)
    return
  end

  local width = 60
  local height = 20
  local row = 1
  local col = vim.o.columns - width - 2

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  float_win = win
  vim.schedule(function()
    if vim.api.nvim_win_is_valid(float_win) then
      vim.api.nvim_set_current_win(float_win)
    end
  end)
end

return {
  'nvim-neotest/neotest',
  opts = {
    summary = {
      open = open_summary_in_floating_window,
      mappings = {
        attach = 'a',
        clear_marked = 'M',
        clear_target = 'T',
        debug = 'd',
        debug_marked = 'D',
        expand = { '<CR>', '<2-LeftMouse>', 'l', 'h' },
        expand_all = 'e',
        help = '?',
        jumpto = 'i',
        mark = 'm',
        next_failed = 'J',
        output = 'o',
        prev_failed = 'K',
        run = 'r',
        run_marked = 'R',
        short = 'O',
        stop = 'u',
        target = 't',
        watch = 'w',
      },
    },
  },
}
