require("nvim-treesitter.configs").setup({
  ensure_installed = {
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
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "elixir", "heex" },
  },
  indent = {
    enable = true,
  },
})
