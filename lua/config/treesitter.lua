vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "c",
    "elixir",
    "go",
    "heex",
    "javascript",
    "json",
    "lua",
    "markdown",
    "ruby",
    "tsx",
    "vim",
    "zig",
  },
  callback = function(args)
    local ok = pcall(vim.treesitter.start, args.buf)

    if not ok then
      vim.bo[args.buf].syntax = "ON"
    end
  end,
})
