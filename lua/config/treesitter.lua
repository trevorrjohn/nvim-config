local parsers = {
  "lua",
  "ruby",
  "javascript",
  "tsx",
  "json",
  "go",
  "zig",
  "c",
  "vim",
  "markdown",
  "elixir",
  "heex",
}

require("nvim-treesitter").install(parsers)

local filetypes = {
  "lua",
  "ruby",
  "javascript",
  "typescriptreact",
  "json",
  "go",
  "zig",
  "c",
  "vim",
  "markdown",
  "elixir",
  "heex",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function(args)
    pcall(vim.treesitter.start)
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "elixir", "heex" },
  callback = function(args)
    vim.bo[args.buf].syntax = "ON"
  end,
})
