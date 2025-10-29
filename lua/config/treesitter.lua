require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "ruby", "javascript", "tsx", "json", "go", "zig", "c", "vim", "markdown", "elixir", "heex" },
  highlight = { enable = true, },
  indent = { enable = true, },
}

