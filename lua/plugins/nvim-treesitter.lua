return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
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
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
