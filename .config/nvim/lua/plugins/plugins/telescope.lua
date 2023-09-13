return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    {
      'nvim-lua/plenary.nvim'
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
  },
  config = function()
    require('telescope').setup {
      defaults = {
        path_display={"smart"},
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous"
          }
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
      }
    }

    require('telescope').load_extension('fzf')
  end
}
