return {
  -- { 'jacoborus/tender.vim', lazy = false, },
  -- { 'bluz71/vim-nightfly-colors', lazy = false, },
  -- { 'NLKNguyen/papercolor-theme', lazy = false },
  -- { 'HoNamDuong/hybrid.nvim', laze = false },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      transparent_mode = true,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.cmd("colorscheme gruvbox")
    end,
  },
  -- { "romainl/Apprentice", lazy = false },
  -- { 'bluz71/vim-moonfly-colors', lazy = false, },
  -- { 'catppuccin/nvim', lazy = false, },
  -- { 'rose-pine/neovim', as = 'rose-pine', },
  -- { "rebelot/kanagawa.nvim", lazy = false, },
  -- { "folke/tokyonight.nvim", lazy = false, },
}
