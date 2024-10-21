return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").ruby_lsp.setup{}
    end,
  },
}
