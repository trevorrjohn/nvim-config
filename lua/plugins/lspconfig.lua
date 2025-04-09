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
      require("lspconfig").lua_ls.setup{
        Lua = {
          runtime = {
            version = "LuaJIT"
          },
          format = {
            indent_style = "space",
            indent_size = "2",
          },
          workspace = {
            userThirdParty = "/home/trevor/workspace/lls-addons",
          },
          library = {
            [vim.fn.expand("/home/trevor/workspace/lls-addons/addons/love2d")] = true,
          },
          globals = { "love", "vim" },
          diagnostics = {
            globals = { "love", "vim" }
          }
        }
      }
    end
  }
}
