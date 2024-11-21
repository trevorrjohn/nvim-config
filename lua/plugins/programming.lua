return {
  -- { "tpope/vim-bundler" },
  -- { "tomtom/tcomment_vim" },
  { "tpope/vim-endwise" },
  { "tpope/vim-rails" },
  -- { "tpope/vim-rake" },
  -- { "tpope/vim-rhubarb" },
  {
    "tpope/vim-dispatch",
    config = function()
      vim.keymap.set("n", "<leader>cc", ":Dispatch<CR>")
    end,
  },
  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "vim-test/vim-test" },
  { "preservim/vimux" },
}
