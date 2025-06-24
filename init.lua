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

vim.g.mapleader = " "

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-t>", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })

vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Grep files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep files" })
vim.keymap.set("c", "Rg", function()
  builtin.grep_string({ search = vim.fn.input("rg > ") })
end)

vim.keymap.set("n", "<C-p>", builtin.buffers, { desc = "View buffers" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "View buffers" })

require("config.settings")
