-- generate your key:
-- echo "mykey" | gpg --encrypt --recipient mymail.com > secrets/mykey.gpg
return {

  {
    'olimorris/codecompanion.nvim',
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
