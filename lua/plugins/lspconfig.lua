return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").ruby_lsp.setup{}
      require("lspconfig").elixirls.setup({
        cmd = {
          "/Users/tj/workspace/elixir-ls/release/language_server.sh"
        }
      })
    end
  }
}
