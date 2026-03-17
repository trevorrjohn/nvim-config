-- Session management functions
local function get_session_name()
  local cwd = vim.fn.getcwd()
  local session_name = cwd:gsub("[/\\:]", "_"):gsub("^_", "")
  return session_name
end

local function get_session_dir()
  return vim.fn.stdpath("data") .. "/sessions"
end

local function get_session_file()
  return get_session_dir() .. "/" .. get_session_name() .. ".vim"
end

local function save_session()
  local session_dir = get_session_dir()

  if vim.fn.isdirectory(session_dir) == 0 then
    local ok = vim.fn.mkdir(session_dir, "p")
    if ok == 0 and vim.fn.isdirectory(session_dir) == 0 then
      return
    end
  end

  local session_file = get_session_file()
  pcall(vim.cmd, "mksession! " .. vim.fn.fnameescape(session_file))
end

local function load_session()
  local session_file = get_session_file()
  if vim.fn.filereadable(session_file) == 1 then
    pcall(vim.cmd, "source " .. vim.fn.fnameescape(session_file))
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
