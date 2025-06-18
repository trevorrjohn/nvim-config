return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- tailwindcss language server
      require("lspconfig").tailwindcss.setup{}

      -- ruby language server
      require("lspconfig").ruby_lsp.setup({ })

      -- go language server
      require("lspconfig").gopls.setup({ })

      -- elxir language server
      if vim.loop.fs_stat("/home/trevor/workspace/elixir-ls/release/language_server.sh") then
        require("lspconfig").elixirls.setup{
          cmd = {
            "/home/trevor/workspace/elixir-ls/release/language_server.sh"
          }
        }
      end

      -- lua language server
      if vim.loop.fs_stat("/home/trevor/workspace/lls-addons/love2d") then
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

      -- zig language server
      if vim.fn.executable("zls") == 1 then
        require("lspconfig").zls.setup{
          cmd = { "zls" },
          on_attach = function(client, bufnr)
            -- Enable format on save
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })
            end
          end,
          settings = {
            zls = {
              enable_build_on_save = true,
              build_on_save_step = "check",  -- This runs 'zig build check'
              -- Or if you have a custom step defined in build.zig:
              -- build_on_save_step = "your_custom_step",
            },
          },
        }
      -- zig language server
      elseif vim.loop.fs_stat("/home/trevor/workspace/zls/zig-out/bin/zls") then
        require("lspconfig").zls.setup{
          settings = {
            zls = {
              enable_build_on_save = true,
              build_on_save_step = "check",  -- This runs 'zig build check'
            }
          },
          cmd = { "/home/trevor/workspace/zls/zig-out/bin/zls" },
          on_attach = function(client, bufnr)
            -- Enable format on save
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })
            end
          end,
        }
      end
    end
  }
}
