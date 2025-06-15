return {
  {
    'tpope/vim-fugitive',
     config = function()
       vim.keymap.set('n','<leader>gs',':Git<CR>',{noremap=true,desc ='git status'}) --git status
       vim.keymap.set('n','<leader>ga',':Git add ',{noremap=true,desc ='git add '})
       vim.keymap.set('n','<leader>gA',':Git add .<CR>',{noremap=true,desc ='git add .'})
       vim.keymap.set('n','<leader>gt',':Git add %',{noremap=true,desc ='git add %p'})
       vim.keymap.set('n','<leader>gp',':Git push --quiet <CR>',{noremap=true,desc ='git push'})
       vim.keymap.set('n','<leader>gc',':Git commit -qam "',{noremap=true,desc ='git commit -am'})
     end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
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
      require('gitsigns').setup({
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
              else
                gitsigns.nav_hunk('next')
              end
            end)

            map('n', '[c', function()
              if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
              else
                gitsigns.nav_hunk('prev')
              end
            end)

            -- Actions
            map('n', '<leader>hs', gitsigns.stage_hunk)
            map('n', '<leader>hr', gitsigns.reset_hunk)

            map('v', '<leader>hs', function()
              gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)

            map('v', '<leader>hr', function()
              gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)

            map('n', '<leader>hS', gitsigns.stage_buffer)
            map('n', '<leader>hR', gitsigns.reset_buffer)
            map('n', '<leader>hp', gitsigns.preview_hunk)
            map('n', '<leader>hi', gitsigns.preview_hunk_inline)

            map('n', '<leader>hb', function()
              gitsigns.blame_line({ full = true })
            end)

            map('n', '<leader>hd', gitsigns.diffthis)

            map('n', '<leader>hD', function()
              gitsigns.diffthis('~')
            end)

            map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
            map('n', '<leader>hq', gitsigns.setqflist)

            -- Toggles
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
            map('n', '<leader>tw', gitsigns.toggle_word_diff)

            -- Text object
            map({'o', 'x'}, 'ih', gitsigns.select_hunk)
          end
        }
      )
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
      wilder.setup({modes = {':', '/', '?'}})

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
  }

}
