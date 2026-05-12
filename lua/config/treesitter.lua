vim.api.nvim_create_autocmd("FileType", {
  pattern = { "elixir", "heex" },
  callback = function(args)
    vim.bo[args.buf].syntax = "ON"
  end,
})
