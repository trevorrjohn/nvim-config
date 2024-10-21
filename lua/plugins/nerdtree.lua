return {
  {
    "preservim/nerdtree",
    lazy = false,
    config = function()
      vim.keymap.set("n", '|', ":NERDTreeFind<CR>")
      vim.keymap.set("n", '\\', ":NERDTreeToggle<CR>")
    end,
  },
}
