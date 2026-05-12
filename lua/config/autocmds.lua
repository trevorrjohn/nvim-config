vim.filetype.add({
  extension = {
    ex = "elixir",
    exs = "elixir",
  },
})

local function is_normal_file_buffer(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
    return false
  end

  if vim.bo[bufnr].buftype ~= "" then
    return false
  end

  if vim.bo[bufnr].filetype == "" or vim.api.nvim_buf_get_name(bufnr) == "" then
    return false
  end

  return true
end

local function notify_missing_buffer_support(bufnr)
  if vim.b[bufnr].support_notice_scheduled then
    return
  end

  vim.b[bufnr].support_notice_scheduled = true

  vim.defer_fn(function()
    if not is_normal_file_buffer(bufnr) or vim.b[bufnr].support_notice_shown then
      return
    end

    local notices = {}
    local filetype = vim.bo[bufnr].filetype

    if #vim.lsp.get_clients({ bufnr = bufnr }) == 0 then
      table.insert(notices, string.format("No LSP attached for '%s'", filetype))
    end

    if not pcall(vim.treesitter.has_parser, filetype) then
      table.insert(notices, string.format("No Treesitter parser for '%s'", filetype))
    end

    if #notices == 0 then
      return
    end

    vim.b[bufnr].support_notice_shown = true
    vim.schedule(function()
      vim.notify(table.concat(notices, " | "), vim.log.levels.INFO, { title = "Editor Support" })
    end)
  end, 800)
end

local buffer_support = vim.api.nvim_create_augroup("buffer_support", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = buffer_support,
  callback = function(args)
    notify_missing_buffer_support(args.buf)
  end,
})

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
