return {
  -- LSP plugins
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    config = function()
      -- lsp-zero configuration
      local lsp_zero = require 'lsp-zero'

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        lsp_zero.buffer_autoformat()
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
        })
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      -- Install language servers
      require('lspconfig').ansiblels.setup({})
      require('lspconfig').bashls.setup({})
      require('lspconfig').gopls.setup({})
      require('lspconfig').helm_ls.setup({})
      require('lspconfig').html.setup({})
      require('lspconfig').htmx.setup({})
      require('lspconfig').jsonls.setup({})
      require('lspconfig').lua_ls.setup({})
      require('lspconfig').pyright.setup({})
      require('lspconfig').rust_analyzer.setup({})
      require('lspconfig').terraformls.setup({})
      require('lspconfig').tflint.setup({})
      require('lspconfig').yamlls.setup({})
    end
  },

  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },

  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
        mapping = cmp.mapping.preset.insert({
          -- Navigate between completion items
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = 'select' },
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = 'select' },

          -- `Enter` key to confirm completion
          ['<C-y>'] = cmp.mapping.confirm { select = false },

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.vim_snippet_jump_forward(),
          ['<C-b>'] = cmp_action.vim_snippet_jump_backward(),

          -- Scroll up and down in the completion documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end
  },

  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({})
    end
  },

  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'rust_analyzer' },
        handlers = {
          function(k8s)
            require('lspconfig')[k8s].setup({})
          end,

          yamlls = function()
            require('lspconfig').yamlls.setup({
              settings = {
                yaml = {
                  schemas = {
                    kubernetes = 'k8s-*.yaml',
                    ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
                    ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
                    ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/**/*.{yml,yaml}',
                    ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
                    ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
                    ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
                    ['http://json.schemastore.org/circleciconfig'] = '.circleci/**/*.{yml,yaml}',
                  },
                },
              },
            })
          end,
        },
      })
    end
  }
}
