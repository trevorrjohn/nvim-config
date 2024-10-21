return {
  -- { 'jacoborus/tender.vim', lazy = false, },
  -- { 'bluz71/vim-nightfly-colors', lazy = false, },
  -- { 'NLKNguyen/papercolor-theme', lazy = false },
  -- { 'HoNamDuong/hybrid.nvim', laze = false },
  {
     "ellisonleao/gruvbox.nvim",
     priority = 1000,
     config = function()
       vim.cmd([[colorscheme gruvbox]])
     end,
  },
  -- { "romainl/Apprentice", lazy = false },
  -- { 'bluz71/vim-moonfly-colors', lazy = false, },
  -- { 'catppuccin/nvim', lazy = false, },
  -- { 'rose-pine/neovim', as = 'rose-pine', },
  -- { "rebelot/kanagawa.nvim", lazy = false, },
  -- { "folke/tokyonight.nvim", lazy = false, },
}
