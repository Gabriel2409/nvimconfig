return {
  {
    'Saghen/blink.cmp',
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<C-y>'] = { 'select_and_accept' },
        -- avoid conflict with tmux
        ['<C-b>'] = {},
        ['<C-g>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-e>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
        ['<C-space>'] = { 'show', 'hide' },
      },
    }
  }
}
