return {
  {
    "arnamak/stay-centered.nvim",
     lazy=false,
     opts = {
       skip_filetypes = { }
     }
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        -- bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 2,
      })
    end,
  },
  {'bullets-vim/bullets.vim'},
  {"folke/todo-comments.nvim",  dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("todo-comments").setup {} end},
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    }
  },
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb'
    },
    config = function()
      vim.keymap.set('n','<leader>gs',':Git<CR>',{noremap=true,desc ='git status'}) --git status
      vim.keymap.set('n','<leader>ga',':Git add ',{noremap=true,desc ='git add '})
      vim.keymap.set('n','<leader>gA',':Git add .<CR>',{noremap=true,desc ='git add .'})
      vim.keymap.set('n','<leader>gt',':Git add %',{noremap=true,desc ='git add %p'})
      vim.keymap.set('n','<leader>gp',':Git push --quiet <CR>',{noremap=true,desc ='git push'})
      vim.keymap.set('n','<leader>gc',':Git commit<CR>',{noremap=true,desc ='git commit -am'})
      vim.keymap.set('n','<leader>gb',':GBrowse<CR>',{noremap=true,desc ='Browse in UI'})
      vim.keymap.set('v','<leader>gb',':GBrowse<CR>', { desc = 'Open selection in GitHub' })
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        sign_priority=100,
        current_line_blame = true,
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
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        accept_suggestion = "<Tab>c"
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { "ruff_format"},
        terraform = { "terraform_fmt"},
        rust = { "rustfmt", lsp_format = "fallback" },
      },
      format_on_save = { timeout_ms = 500 },
    },
  },
  { 
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.files').setup({
        mappings = {
          go_in_plus = "<CR>"
        },
        windows = {
          preview = true,
          width_preview = 100
        }
      })
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    lazy = false,
    config = function()
      require('scrollbar').setup({
        handle = {
            color = "#1c1c1c",
        },
      })
      require("scrollbar.handlers.gitsigns").setup()
    end
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()
      local kopts = {noremap = true, silent = true}

      vim.api.nvim_set_keymap('n', 'n',
          [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts)
      vim.api.nvim_set_keymap('n', 'N',
          [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

      vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
    end
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      bigfile = {},
      -- scroll = {},
      picker = {
        layout ={
          preset = "ivy",
          cycle = false,
          preview = false
        },
        matcher = {
          frecency = true
        },
        formatters = {
          file = {
            truncate = 100, -- Set to 0 to avoid truncation
          },
        },
      },
      lazygit = {},
      notifier = {},
      zen = {},
      scratch = {},
      dashboard = {
        enabled = true,
        formats = {
          key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
          end,
        },
        sections = {
          { section = "terminal", cmd = "fortune -s", hl = "header", indent = 8, ttl = 0 },
          { title = "Bookmarks", padding = 1 },
          { section = "keys" },
        },
        preset = {
          keys = {
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles', {filter = {cwd = true}})" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files', {cwd = true})" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          }
        }
      },
      indent = {
        enabled = true,
        indent = {
          -- only_scope = true,
          hl = {
            'Hidden',
            'SnacksIndent',
            'SnacksIndent',
            'SnacksIndent',
            'SnacksIndent',
            'SnacksIndent',
            'SnacksIndent',
            'SnacksIndent',
            'SnacksIndent',
          }
        },
        scope = {
          hl = {
            'Hidden',
            'SnacksIndentScope',
            'SnacksIndentScope',
            'SnacksIndentScope',
            'SnacksIndentScope',
            'SnacksIndentScope',
            'SnacksIndentScope',
            'SnacksIndentScope',
            'SnacksIndentScope',
          }
        }
      }
    },
    keys = {
      { "<Leader>lg", function() Snacks.lazygit() end, desc = "LazyGit" },
      { "<Leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<Leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      { "<Leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<C-p>", function() Snacks.picker.smart({ filter = { cwd = true }}) end, desc = "Smart Find Files" },
      { "<C-g>", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

      local dropbar = require('dropbar')
      local sources = require('dropbar.sources')
      -- dropbar.setup({
      --   bar = {
      --     sources = {
      --       sources.path,
      --     },
      --   }
      -- })
    end
  },
  {
    "yutkat/confirm-quit.nvim",
    event = "CmdlineEnter",
    opts = {},
  },
  {
    'akinsho/toggleterm.nvim', 
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
    }
  },
  {
    "coder/claudecode.nvim",
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<c-l>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<c-l>", "<cmd>ClaudeCode<cr>", mode = "t", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<c-k>", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {}
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  }
}
