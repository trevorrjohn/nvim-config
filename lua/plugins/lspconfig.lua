return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp' },
  },
  config = function()
    vim.lsp.config("tailwindcss", {})
    vim.lsp.config("ruby_lsp", {})
    vim.lsp.config("gopls", {})
    vim.lsp.config("elixirls", {})
    vim.lsp.config("lua_ls", {
      settings = {
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
    })

    vim.lsp.config("zls", {
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
    })
  end,
}
