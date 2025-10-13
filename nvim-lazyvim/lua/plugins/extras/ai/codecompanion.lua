-- generate your key:
-- echo "mykey" | gpg --encrypt --recipient mymail.com > secrets/mykey.gpg
-- accept change: ga. Reject: gr. Launch prompt Ctrl s.
vim.cmd [[cab cc CodeCompanion]]

return {
  -- {
  --   'ravitemer/mcphub.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   cmd = 'MCPHub',
  --   build = 'bundled_build.lua', -- Bundles mcp-hub locally
  --   config = function()
  --     require('mcphub').setup {
  --       -- Server configuration
  --       use_bundled_binary = true, -- Use local binary
  --       port = 37373, -- Port for MCP Hub Express API
  --       config = vim.fn.expand '~/.config/mcphub/servers.json', -- Config file path
  --
  --       native_servers = {}, -- add your native servers here
  --       -- Extension configurations
  --       auto_approve = false,
  --       extensions = {
  --         codecompanion = {
  --           show_result_in_chat = true, -- Show tool results in chat
  --           make_vars = true, -- Create chat variables from resources
  --           make_slash_commands = true, -- make /slash_commands from MCP server prompts
  --         },
  --       },
  --
  --       -- UI configuration
  --       ui = {
  --         window = {
  --           width = 0.8, -- Window width (0-1 ratio)
  --           height = 0.8, -- Window height (0-1 ratio)
  --           border = 'rounded', -- Window border style
  --           relative = 'editor', -- Window positioning
  --           zindex = 50, -- Window stack order
  --         },
  --       },
  --
  --       -- Event callbacks
  --       on_ready = function(hub) end, -- Called when hub is ready
  --       on_error = function(err) end, -- Called on errors
  --
  --       -- Logging configuration
  --       log = {
  --         level = vim.log.levels.WARN, -- Minimum log level
  --         to_file = false, -- Enable file logging
  --         file_path = nil, -- Custom log file path
  --         prefix = 'MCPHub', -- Log message prefix
  --       },
  --     }
  --   end,
  -- },
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
          tools = {
            ['mcp'] = {
              -- Prevent mcphub from loading before needed
              callback = function()
                return require 'mcphub.extensions.codecompanion'
              end,
              description = 'Call tools and resources from the MCP Servers',
            },
          },
        },
        inline = {
          adapter = 'openai',
        },
      },
    },
  },
}
