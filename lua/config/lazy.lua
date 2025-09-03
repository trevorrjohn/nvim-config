-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=main",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "lazyvim.plugins" },                 -- 1) core
    -- { import = "lazyvim.plugins.extras.lang.typescript" }, -- 2) any extras you use
    { import = "plugins" },                         -- 3) your stuff
  },
  install = { colorscheme = { "gruvbox" } },
  checker = { enabled = true },
})
