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


vim.cmd.colorscheme "catppuccin"
vim.o.clipboard = "unnamed"
vim.o.scrolloff = 8
vim.o.number = true
vim.o.relativenumber = true
vim.o.undofile =  true
vim.o.ts =  4
vim.o.sw = 4
vim.o.sts = 4
