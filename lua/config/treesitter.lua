require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "ruby", "javascript", "tsx", "json", "go", "zig" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

