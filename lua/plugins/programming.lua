return {
  -- { "tpope/vim-bundler" },
  -- { "tomtom/tcomment_vim" },
  { "tpope/vim-endwise" },
  { "tpope/vim-rails" },
  -- { "tpope/vim-rake" },
  -- { "tpope/vim-rhubarb" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "tpope/vim-dispatch" },
  {
    "vim-test/vim-test",
    config = function()
      -- save before running tests
      vim.g["test#autowrite"] = 1
      -- use dispatch to run tests
      vim.g["test#strategy"] = "dispatch"
      vim.keymap.set("n", "<leader>tt", ":TestLast<CR>")
      vim.keymap.set("n", "<leader>tf", ":TestFile<CR>")
      vim.keymap.set("n", "<leader>tl", ":TestNearest<CR>")
    end,
  },
  -- { "preservim/vimux" },
}
