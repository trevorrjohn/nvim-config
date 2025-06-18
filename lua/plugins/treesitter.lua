return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "go", "vim", "vimdoc", "query", "ruby", "rbs", "zig", "elixir", "heex", "markdown", "markdown_inline", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = {
          enable = true,
          disable = {},
        },
      })
      vim.cmd("autocmd FileType ruby setlocal indentkeys-=.")
    end,
  },
}
