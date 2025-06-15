return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function()
      local cmp = require("cmp")

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
          { name = 'nvim_lsp' }
        }, {
          { name = 'buffer' },
        })

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
      lspconfig.pyright.setup {}
    end
  }
}
