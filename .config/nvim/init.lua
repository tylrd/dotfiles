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

vim.cmd.colorscheme "catppuccin"
vim.o.clipboard = "unnamed"
vim.o.cursorline = true
vim.o.scrolloff = 9999
vim.o.number = true
vim.o.relativenumber = true
vim.o.undofile =  true
vim.o.ts = 2
vim.o.sw = 2
vim.o.sts = 2
vim.o.expandtab = true
vim.o.list = true
vim.o.listchars = 'tab:▷┅,trail:•'
vim.o.wildmenu = true

vim.diagnostic.config({
  virtual_text = false
})

function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<leader>w", ":w<cr>")
map("n", "-", ":NvimTreeOpen<cr>")
map("n", "<CR>", ":noh<CR><CR>")
map('n', '<leader>e', vim.diagnostic.open_float)

local builtin = require('telescope.builtin')
map("n", "<C-f>", builtin.find_files)
map("n", "<C-g>", builtin.live_grep)
map("n", "<C-b>", builtin.buffers)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.references, opts)
  end,
})