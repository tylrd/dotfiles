return {
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
      require('gitsigns').setup()
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
