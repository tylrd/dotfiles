return {
  'tpope/vim-surround',
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      config = function()
        require('ts_context_commentstring').setup {
          enable_autocmd = false,
        }
      end
    },
    config = function()
      require('Comment').setup {
        toggler = {
            ---Line-comment toggle keymap
            line = 'gcl',
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    lazy = false,
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      -- setup keybindings for gitsigns
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
  },
  {
    'gelguy/wilder.nvim',
    dependencies = {
      'romgrk/fzy-lua-native',
      build = 'make'
    },
    config = function()
      local wilder = require('wilder')
      wilder.setup({
        modes = {':', '/', '?'},
        next_key = '<C-j>',
        previous_key = '<C-k>',
        accept_key = '<Tab>'
      })

      wilder.set_option('pipeline', {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            set_pcre2_pattern = 1,
          }),
          wilder.python_search_pipeline({
            pattern = 'fuzzy',
          })
        ),
      })

      local highlighters = {
        wilder.lua_fzy_highlighter()
      }

      wilder.set_option('renderer', wilder.renderer_mux({
        [':'] = wilder.popupmenu_renderer({
          highlighter = highlighters,
          highlights = {
            accent = wilder.make_hl('WilderAccent', 'Pmenu', {{a = 1}, {a = 1}, {foreground = '#f4468f'}}),
          },
          left = {' ', wilder.popupmenu_devicons()},
          right = {' ', wilder.popupmenu_scrollbar()},
        }),
        ['/'] = wilder.wildmenu_renderer({
          highlighter = highlighters,
        }),
      }))
    end
  },
  {
    'mattn/emmet-vim'
  },
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup{
        open_mapping = '<C-t>',
        direction = 'horizontal',
        float_opts = {
          border = "curved"
        }
      }
    end,
    event = "VeryLazy",
    version = "*",
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {
        settings = {
          complete_function_calls = true,
          tsserver_file_preferences = {
            importModuleSpecifierPreference = 'non-relative'
          },
          tsserver_format_options = {
            allowRenameOfImportPath = true,
          }
        }
      }
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true
  }
}
