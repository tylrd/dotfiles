return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      view = {
        width = 30,
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      actions = {
        open_file = {
          resize_window = false
        }
      }
    })
  end
}
