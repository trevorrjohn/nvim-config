local telescope = require("telescope.builtin")

-- Enable LSP-based completion
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- LSP core
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
    map("n", "gr", vim.lsp.buf.references, "Find references")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

    -- Diagnostics
    map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
    map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = false }) end, "Previous diagnostic")
    map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = false }) end, "Next diagnostic")

    -- Telescope-powered LSP browsing
    map("n", "<leader>fr", telescope.lsp_references, "Telescope: references")
    map("n", "<leader>fd", telescope.lsp_definitions, "Telescope: definitions")
    map("n", "<leader>fi", telescope.lsp_implementations, "Telescope: implementations")
    map("n", "<leader>fs", telescope.lsp_document_symbols, "Telescope: symbols (file)")
    map("n", "<leader>fS", telescope.lsp_workspace_symbols, "Telescope: symbols (workspace)")
  end,
})


local lua_library_paths = vim.api.nvim_get_runtime_file("", true)
local love_types = vim.fn.expand("~/workspace/love2d-types")
-- Use vim.fn.isdirectory() to check if the directory exists
if vim.fn.isdirectory(love_types) == 1 then
  table.insert(lua_library_paths, love_types)
end

-- Setup example servers (manual install required)
vim.lsp.config('lua_ls', {
  on_attach = function(_, bufnr)
    -- Format on save for Lua files
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", "love" } },
      workspace = {
        library = lua_library_paths,
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('ruby_lsp', {})

vim.lsp.config("gopls", {
  on_attach = function(_, bufnr)
    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
})


local elixirls = vim.fn.expand("~/.local/share/mise/installs/elixir-ls/0.29.3/language_server.sh")


vim.lsp.config("elixirls", {
  cmd = { elixirls, "--stdio" },           -- explicit stdio
  settings = { elixirLS = { dialyzerEnabled = false, fetchDeps = false } },
})
