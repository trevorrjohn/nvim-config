local telescope = require("telescope.builtin")

local function format_buffer(async)
  local ok, conform = pcall(require, "conform")
  if ok then
    conform.format({ async = async, lsp_format = "fallback" })
  else
    vim.lsp.buf.format({ async = async })
  end
end

local function notify_missing_lsp(name, cmd)
  vim.schedule(function()
    vim.notify(
      string.format("LSP '%s' is enabled but '%s' is not installed or not executable", name, cmd),
      vim.log.levels.WARN
    )
  end)
end

local function notify_disabled_lsp(name, reason)
  vim.schedule(function()
    vim.notify(string.format("LSP '%s' was not enabled: %s", name, reason), vim.log.levels.WARN)
  end)
end

local function mise_shim_error(cmd)
  if type(cmd) == "table" then
    cmd = cmd[1]
  end

  local path = vim.fn.exepath(cmd)
  if path == "" or not path:find("/mise/shims/", 1, true) or vim.fn.executable("mise") ~= 1 then
    return nil
  end

  local result = vim.system({ "mise", "which", cmd }, { text = true }):wait()
  if result.code == 0 then
    return nil
  end

  return string.format("mise shim '%s' is not active; run `mise use` in the project that needs it", cmd)
end

local function definition_or_picker()
  local params = vim.lsp.util.make_position_params()
  local results = vim.lsp.buf_request_sync(0, "textDocument/definition", params, 800)

  if results then
    local has_locations = false
    for _, response in pairs(results) do
      local result = response.result
      if result then
        if vim.tbl_islist(result) then
          if #result > 0 then
            has_locations = true
            break
          end
        elseif result.uri or result.targetUri then
          has_locations = true
          break
        end
      end
    end

    if has_locations then
      vim.lsp.buf.definition()
      return
    end
  end

  telescope.lsp_definitions()
end

local function enable_if_available(name, cmd)
  local is_available

  if type(cmd) == "table" then
    local bin = cmd[1]
    is_available = vim.fn.executable(bin) == 1
  else
    is_available = vim.fn.executable(cmd) == 1
  end

  local shim_error = is_available and mise_shim_error(cmd)

  if is_available and not shim_error then
    vim.lsp.enable(name)
  elseif shim_error then
    notify_disabled_lsp(name, shim_error)
  else
    notify_missing_lsp(name, shim_error or (type(cmd) == "table" and cmd[1] or cmd))
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
    map("n", "gd", definition_or_picker, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
    map("n", "gr", vim.lsp.buf.references, "Find references")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>lf", function() format_buffer(true) end, "Format buffer")

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

vim.lsp.config("ts_ls", {
})


local elixirls_cmd
if vim.fn.executable("elixir-ls") == 1 then
  elixirls_cmd = { "elixir-ls", "--stdio" }
else
  notify_missing_lsp("elixirls", "elixir-ls")
end

if elixirls_cmd then
  vim.lsp.config("elixirls", {
    cmd = elixirls_cmd,
    settings = { elixirLS = { dialyzerEnabled = false, fetchDeps = false } },
  })
end

enable_if_available("lua_ls", "lua-language-server")
enable_if_available("ruby_lsp", "ruby-lsp")
enable_if_available("ts_ls", "typescript-language-server")

if elixirls_cmd then
  vim.lsp.enable("elixirls")
end
