return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").tailwindcss.setup{}
      require("lspconfig").ruby_lsp.setup({ })
      -- require("lspconfig").gopls.setup({ })
      require("lspconfig").elixirls.setup({
        cmd = {
          "/home/trevor/workspace/elixir-ls/release/language_server.sh"
        }
      })
    end
  }
}
