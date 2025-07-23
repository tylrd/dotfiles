vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
vim.cmd.colorscheme "jellybeans"
vim.o.clipboard = "unnamed"
vim.o.cursorline = true

vim.o.laststatus = 0
vim.o.signcolumn = "auto:2"
vim.o.confirm = true
-- vim.o.scrolloff = 9999
vim.o.number = true
vim.o.undofile =  true
vim.o.ts = 2
vim.o.sw = 2
vim.o.sts = 2
vim.o.expandtab = true
vim.o.list = true
vim.o.listchars = 'tab:▷┅,trail:•'
vim.o.wildmenu = true
vim.o.swapfile = false
vim.o.autowriteall = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

vim.diagnostic.config({
  virtual_text = false
})

vim.cmd('highlight WinBar guibg=NONE')
vim.cmd.cnoreabbrev("wq", "w")
vim.cmd.cnoreabbrev("Wq", "w")
vim.cmd.cnoreabbrev("qw", "w")
vim.cmd.cnoreabbrev("W", "w")
vim.cmd.cnoreabbrev("WQ", "wq")
vim.cmd.cnoreabbrev("Qa", "qa")
vim.cmd.cnoreabbrev("Bd", "bd")
vim.cmd.cnoreabbrev("bD", "bd")
vim.cmd.cnoreabbrev("bD", "bd")
vim.cmd.cnoreabbrev("Q", "q")

function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<leader>w", ":w<cr>")

vim.keymap.set("n", "-", function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
  MiniFiles.open(path)
  MiniFiles.reveal_cwd()
end, { desc = "Open Mini Files" })

map("n", "<C-f>", function() Snacks.picker.smart({filter = { cwd = true }}) end)
map("n", "<C-b>", function() Snacks.picker.buffers() end)
map("n", "<CR>", ":noh<CR><CR>")
map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '<space>ca', function()
    vim.lsp.buf.code_action({apply=true}) end)
map('n', '<leader><leader>', ':noh<CR>')
map('n', '<leader>b', ':b#<CR>')
-- map('n', '<leader>lb', ':Gitsigns blame_line<CR>')
map('n', 'c', '"_c')
map('n', 'v', '"_v')
map('n', '<leader>qs', function() require("persistence").load() end)
map('n', '<leader>qS', function() require("persistence").select() end)


vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function()
    vim.keymap.set("n", "q", ":q<CR>", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    vim.keymap.set("n", "q", ":q<CR>", { buffer = true })
  end,
})

-- Open files at last known line
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match('commit') and ft:match('rebase'))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- Toggle quickfix
vim.keymap.set("n", "<leader>q", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle quickfix" })

vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#928374" })
vim.api.nvim_set_hl(0, "Hidden", { fg = "#121212" })


-- clear quickfix
vim.keymap.set("n", "<leader>c", ":cexpr []<CR>", { desc = "Clear quickfix" })

-- Toggle Term 
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

function split_terminal_right()
  local Terminal = require('toggleterm.terminal').Terminal
  Terminal:new({direction='horizontal'}):open()
end

vim.api.nvim_create_user_command('SplitTerminal', split_terminal_right, {})
vim.keymap.set({"t"}, "<c-t>", "<cmd>SplitTerminal<cr>")
