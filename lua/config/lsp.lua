local telescope = require("telescope.builtin")

local function format_on_save(_, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

local function notify_missing_lsp(name, cmd)
  vim.schedule(function()
    vim.notify(
      string.format("LSP '%s' is enabled but '%s' is not installed or not executable", name, cmd),
      vim.log.levels.WARN
    )
  end)
end

local function enable_if_available(name, cmd)
  local is_available

  if type(cmd) == "table" then
    local bin = cmd[1]
    is_available = vim.fn.executable(bin) == 1
  else
    is_available = vim.fn.executable(cmd) == 1
  end

  if is_available then
    vim.lsp.enable(name)
  else
    notify_missing_lsp(name, type(cmd) == "table" and cmd[1] or cmd)
  end
end

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
  on_attach = format_on_save,
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
  on_attach = format_on_save,
})

vim.lsp.config("ts_ls", {
  on_attach = format_on_save,
})


vim.lsp.config("elixirls", {
  cmd = { elixirls, "--stdio" },           -- explicit stdio
  settings = { elixirLS = { dialyzerEnabled = false, fetchDeps = false } },
})

local elixirls = vim.fn.expand("~/.local/share/mise/installs/elixir-ls/0.29.3/language_server.sh")

enable_if_available("lua_ls", "lua-language-server")
enable_if_available("ruby_lsp", "ruby-lsp")
enable_if_available("gopls", "gopls")
enable_if_available("ts_ls", "typescript-language-server")
enable_if_available("elixirls", { elixirls, "--stdio" })
