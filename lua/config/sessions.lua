-- Session management functions
local function get_session_name()
  local cwd = vim.fn.getcwd()
  local session_name = cwd:gsub("[/\\:]", "_"):gsub("^_", "")
  return session_name
end

local function save_session()
  local session_name = get_session_name()
  local session_dir = vim.fn.stdpath("data") .. "/sessions"
  vim.fn.mkdir(session_dir, "p")
  local session_file = session_dir .. "/" .. session_name .. ".vim"
  vim.cmd("mksession! " .. session_file)
end

local function load_session()
  local session_name = get_session_name()
  local session_file = vim.fn.stdpath("data") .. "/sessions/" .. session_name .. ".vim"
  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd("source " .. session_file)
  end
end

-- Session-aware file picker
local session_files = function()
  require('telescope.builtin').oldfiles({
    prompt_title = "Session Files",
    cwd_only = true,
    sort_lastused = true,
  })
end

-- Auto-save session on exit
vim.api.nvim_create_autocmd("VimLeave", {
  callback = save_session,
})

-- Auto-load session on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      load_session()
    end
  end,
})

-- Replace your buffer keymaps
vim.keymap.set("n", "<C-p>", session_files, { desc = "View session files" })
vim.keymap.set("n", "<leader>fb", session_files, { desc = "View session files" })
