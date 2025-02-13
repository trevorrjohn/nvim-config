return {
  {
    "nvim-telescope/telescope.nvim",
  },
  {
    config = function()
      require("telescope").load_extension("recent_files")

      vim.api.nvim_set_keymap("n", "<C-p>",
        [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
        {noremap = true, silent = true})


      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<Leader>f", builtin.find_files, {})
      vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
      vim.keymap.set("i", "<C-f>", builtin.live_grep, {})
      vim.keymap.set("c", "Rg", function()
        builtin.grep_string({ search = vim.fn.input("rg > ") })
      end)
      vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end,
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && make --build build --config Release",
    dependencies = { "smartpde/telescope-recent-files" },
  },
}
