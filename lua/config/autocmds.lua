  -- Auto format and strip trailing whitespace (only modified lines in Git)
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null") ~= "true\n" then return end
    local bufnr = vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then return end
    -- Strip whitespace only on modified diff hunks
    vim.cmd("%s/\\s\\+$//e")
  end,
})

-- Highlight modified lines
  -- vim.api.nvim_create_autocmd({ "BufRead", "TextChanged", "BufWritePost" }, {
  --   callback = function()
  --     vim.cmd("syntax clear DiffChange")
  --     vim.cmd("diffthis")
  --     vim.cmd("normal! <%")
  --     vim.cmd("normal! >%")
  --     vim.cmd("diffupdate")
  --   end,
  -- })

