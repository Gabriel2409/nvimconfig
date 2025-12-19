return {
  {
    'Saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    opts = {
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = { documentation = { auto_show = true } },
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

-- kinds = {
--   Array         = " ",
--   Boolean       = "󰨙 ",
--   Class         = " ",
--   Codeium       = "󰘦 ",
--   Color         = " ",
--   Control       = " ",
--   Collapsed     = " ",
--   Constant      = "󰏿 ",
--   Constructor   = " ",
--   Copilot       = " ",
--   Enum          = " ",
--   EnumMember    = " ",
--   Event         = " ",
--   Field         = " ",
--   File          = " ",
--   Folder        = " ",
--   Function      = "󰊕 ",
--   Interface     = " ",
--   Key           = " ",
--   Keyword       = " ",
--   Method        = "󰊕 ",
--   Module        = " ",
--   Namespace     = "󰦮 ",
--   Null          = " ",
--   Number        = "󰎠 ",
--   Object        = " ",
--   Operator      = " ",
--   Package       = " ",
--   Property      = " ",
--   Reference     = " ",
--   Snippet       = "󱄽 ",
--   String        = " ",
--   Struct        = "󰆼 ",
--   Supermaven    = " ",
--   TabNine       = "󰏚 ",
--   Text          = " ",
--   TypeParameter = " ",
--   Unit          = " ",
--   Value         = " ",
--   Variable      = "󰀫 ",
-- },
