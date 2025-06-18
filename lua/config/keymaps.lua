-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- stop highlighting
vim.keymap.set("n", "<C-c>", ":noh<Esc>")

-- binging.pry
vim.keymap.set("i", "bp<tab>", "binding.pry<Esc>")

-- hash rocket for ruby
vim.keymap.set("i", "<c-l>", "<space>=><space>")

-- insert newline
vim.keymap.set("n", "[<space>", ":put! _<ESC>j")
vim.keymap.set("n", "]<space>", ":put _<ESC>k")

-- some generic ones that make it easier
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-k>", function()
  -- Try location list first
  if #vim.fn.getloclist(0) > 0 then
    pcall(vim.cmd, "lnext")
  else
    pcall(vim.cmd, "cnext")
  end
  vim.cmd("normal! zz")
end)

vim.keymap.set("n", "<C-j>", function()
  -- Try location list first
  if #vim.fn.getloclist(0) > 0 then
    pcall(vim.cmd, "lprev")
  else
    pcall(vim.cmd, "cprev")
  end
  vim.cmd("normal! zz")
end)

-- save with W
vim.keymap.set("c", "W", "w")

-- Tab completion
-- will insert tab at beginning of line,
-- will use completion if not at beginning
-- vim.cmd[[
--   set wildmode=list:longest,list:full
--   function! InsertTabWrapper()
--       let col = col('.') - 1
--       if !col || getline('.')[col - 1] !~ '\k'
--           return "\<Tab>"
--       else
--           return "\<C-p>"
--       endif
--   endfunction
--   inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
--   inoremap <S-Tab> <C-n>
-- ]]

-- Switch between the last two files
vim.keymap.set("n", "<Leader><Leader>", "<C-^>")

-- open diagnostics for sidebar
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)

-- Vim LSP show methods on object
vim.keymap.set('i', '<C-k>', '<C-x><C-o>', { desc = 'Trigger omni completion' })

-- Use Tab/Shift-Tab for navigation
vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true, desc = 'Move to next completion item' })

vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true, desc = 'Move to previous completion item' })

-- Enter to confirm
vim.keymap.set('i', '<CR>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true, desc = 'Confirm completion or new line' })

vim.opt.completeopt = 'menuone,noselect,noinsert'
