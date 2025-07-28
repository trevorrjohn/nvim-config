-- Bootstrap lazy.nvim (if not installed)
require("config.lazy")

-- Load plugins and config
require("config.autocmds")
require("config.lsp")
require("config.telescope")
require("config.treesitter")
require("config.luasnip")
require("config.test")
--
vim.g.mapleader = " "

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-t>", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })

vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Grep files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep files" })
vim.keymap.set("c", "Rg", function()
  builtin.grep_string({ search = vim.fn.input("rg > ") })
end)

vim.keymap.set("n", "<C-p>",
  function() builtin.buffers({ sorter_lastused = true, sort_mru = true }) end,
  { desc = "View buffers" })
vim.keymap.set("n", "<leader>fb",
  function() builtin.buffers({ sorter_lastused = true, sort_mru = true }) end,
  { desc = "View buffers" })

require("config.settings")
require("config.sessions")
