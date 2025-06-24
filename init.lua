-- Bootstrap lazy.nvim (if not installed)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv or not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--depth=1",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins and config
require("plugins")
require("config.autocmds")
require("config.lsp")
require("config.telescope")
require("config.treesitter")
require("config.luasnip")
require("config.test")
require("config.settings")

vim.g.mapleader = " "

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "View buffers" })
vim.keymap.set("n", "<C-p>", builtin.buffers, { desc = "View buffers" })

vim.api.nvim_create_user_command("ReloadConfig", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^config") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end, {})
