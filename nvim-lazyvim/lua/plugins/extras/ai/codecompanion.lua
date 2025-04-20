-- generate your key:
-- echo "mykey" | gpg --encrypt --recipient mymail.com > secrets/mykey.gpg
-- accept change: ga. Reject: gr. Launch prompt Ctrl s.
vim.cmd [[cab cc CodeCompanion]]
return {
  {
    'olimorris/codecompanion.nvim',
    keys = {

      {
        mode = { 'n' },
        '<leader>C',
        '<cmd>CodeCompanionChat Toggle<cr>',
        desc = 'Code Companion Chat',
      },
    },
    opts = {
      adapters = {
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = 'cmd: gpg --batch --quiet --decrypt  ~/.config/nvim/secrets/anthropic.gpg',
            },
          })
        end,
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = 'cmd: gpg --batch --quiet --decrypt  ~/.config/nvim/secrets/openai.gpg',
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = 'openai',
        },
        inline = {
          adapter = 'openai',
        },
      },
    },
  },
}
