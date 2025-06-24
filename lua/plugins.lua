return require("lazy").setup({
  { "neovim/nvim-lspconfig" },
  { "L3MON4D3/LuaSnip" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    },
  },
  "vim-test/vim-test",
  "tpope/vim-dispatch",
  {
    "morhetz/gruvbox",
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"   -- or "light"

      -- Everforest theme options

      vim.cmd.colorscheme("gruvbox")
    end
  },
})

