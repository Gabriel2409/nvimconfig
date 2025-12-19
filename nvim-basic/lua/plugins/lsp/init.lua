return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
    },

    opts_extend = { 'servers', 'servers.*.keys' },
    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = false,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = true,
          prefix = '●',
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
          },
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim.
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
        exclude = {},
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim.
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },

      -- Enable this to enable the builtin LSP folding on Neovim.
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the folds.

      folds = {
        enabled = true,
      },
      servers = {
        ['*'] = {
          capabilities = {
            workspace = {
              fileOperations = {
                didRename = true,
                willRename = true,
              },
            },
          },
            -- stylua: ignore
            keys = {
              { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
              { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
              { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
              { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
              { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
              { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
              { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
              { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp" },
              { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" }, has = "codeAction" },
              { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" }, has = "codeLens" },
              { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
              { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
              { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
            },
        },
      },
    },
    config = function(_, opts)
      -- Apply diagnostic config
      vim.diagnostic.config(opts.diagnostics)

      -- 2. Setup keymaps when LSP attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          local bufnr = args.buf

          -- Apply keymaps from servers['*']
          if opts.servers['*'] and opts.servers['*'].keys then
            for _, key in ipairs(opts.servers['*'].keys) do
              local mode = key.mode or 'n'
              vim.keymap.set(mode, key[1], key[2], {
                buffer = bufnr,
                desc = key.desc,
              })
            end
          end

          if opts.inlay_hints.enabled then
            local buffer = args.buf
            if client:supports_method('textDocument/inlayHint', buffer) then
              if
                vim.api.nvim_buf_is_valid(buffer)
                and vim.bo[buffer].buftype == ''
                and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
              then
                vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
              end
            end
          end

          -- Enable LSP folding (inside LspAttach autocmd)
          if opts.folds.enabled then
            if client:supports_method 'textDocument/foldingRange' then
              -- Only set if not already configured
              if vim.wo.foldmethod == 'manual' then
                vim.wo.foldmethod = 'expr'
                vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
              end
            end
          end
        end,
      })

      -- 3. Configure servers
      if opts.servers['*'] then
        local star_config = vim.deepcopy(opts.servers['*'])
        star_config.keys = nil -- Remove keys, we handle them separately
        vim.lsp.config('*', star_config)
      end

      for server, server_opts in pairs(opts.servers) do
        if server ~= '*' then
          local config = vim.deepcopy(server_opts)
          config.keys = nil
          vim.lsp.config(server, config)
        end
      end

      -- 4. Setup mason-lspconfig
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'ty', 'ruff' },
      }
    end,
  },
  {

    'mason-org/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger {
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
