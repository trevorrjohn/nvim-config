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

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

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
