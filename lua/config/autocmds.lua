-- save when changing buffer or window
local autosave = vim.api.nvim_create_augroup("autosave", { clear = true })

vim.api.nvim_create_autocmd(
  {"FocusLost", "BufLeave", "WinLeave"},
  {
    group = autosave,
    pattern = "*",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
      local modifiable = vim.api.nvim_buf_get_option(buf, 'modifiable')

      -- Only save normal, modifiable buffers that have a filename
      if buftype == '' and modifiable and vim.fn.expand('%') ~= '' then
        vim.cmd("silent! update")
      end
    end
  }
)
