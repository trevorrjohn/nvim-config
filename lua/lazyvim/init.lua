lopal lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

require("lazy").setup({
  { "github/copilot.vim", },
  { 'tpope/vim-bundler' },
  { 'tpope/vim-endwise' },
  { 'tpope/vim-eunuch' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-projectionist' },
  { 'tpope/vim-rails' },
  { 'tpope/vim-rake' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-surround' },
  { "tpope/vim-dispatch" },
  { "tomtom/tcomment_vim" },
  { 'vim-test/vim-test' },
  { "preservim/vimux" },
  { 'preservim/nerdtree' },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { "smartpde/telescope-recent-files" },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  -- COLOR Schemes
  -- { 'jacoborus/tender.vim', lazy = false, },
  -- { 'bluz71/vim-nightfly-colors', lazy = false, },
  -- { 'NLKNguyen/papercolor-theme', lazy = false },
  -- { 'HoNamDuong/hybrid.nvim', laze = false },
  { "ellisonleao/gruvbox.nvim", lazy = false },
  -- { "romainl/Apprentice", lazy = false },
  -- { 'bluz71/vim-moonfly-colors', lazy = false, },
  -- { 'catppuccin/nvim', lazy = false, },
  -- { 'rose-pine/neovim', as = 'rose-pine', },
  -- { "rebelot/kanagawa.nvim", lazy = false, },
  -- { "folke/tokyonight.nvim", lazy = false, },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "ruby", "elixir", "heex", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
})
