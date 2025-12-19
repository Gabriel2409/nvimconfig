return {
  {
    'Saghen/blink.cmp',
    opts = {
      keymap = {
        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          'snippet_forward',
          'fallback',
        },
        ['<C-y>'] = { 'select_and_accept' },
        -- avoid conflict with tmux
        ['<C-b>'] = {},
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-g>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-e>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
        ['<C-space>'] = { 'show', 'hide' },
      },
    },
  },
}
