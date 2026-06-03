return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate lua ruby javascript tsx json go zig c vim markdown elixir heex",
    config = function()
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

      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install(parsers)
    end,
  },
}
