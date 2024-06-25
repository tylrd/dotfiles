return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = function()
          require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 2,
          })
        end
      },
      { 'jackieaskins/cmp-emmet', build = 'npm run release'  }
    },
    config = function()
      local cmp = require("cmp")
      local cmp_tailwind = require("tailwindcss-colorizer-cmp")
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      -- Adds parentheses when a function is selected
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-p>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          -- ["<Tab>"] = cmp.mapping(function(fallback)
          --   -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
          --   if cmp.visible() then
          --     local entry = cmp.get_selected_entry()
          --     if not entry then
          --       cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          --     else
          --       cmp.confirm()
          --     end
          --   else
          --     fallback()
          --   end
          -- end, {"i","s","c",}),
        }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          -- { name = 'emmet' },
          { name = 'nvim_lsp_signature_help' },
          {
            name = "treesitter",
          },
        }),

        formatting = {
          format = require('lspkind').cmp_format(
            { 
              mode = 'symbol_text',
              maxwidth = 50,
              ellipsis_char = '...',
              before = function(entry, vim_item)
                cmp_tailwind.formatter(entry, vim_item)
                return vim_item
              end,
            }
          )
        },

        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig')['pyright'].setup {
        capabilities = capabilities
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        automatic_installation = true
      }
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.pyright.setup {}
      lspconfig.tailwindcss.setup {}
      -- lspconfig.tsserver.setup {
      --  capabilities = lsp_capabilities,
      -- }
    end
  }
}
