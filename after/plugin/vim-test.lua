-- https://github.com/vim-test/vim-test
vim.keymap.set("n", "<Leader>t", ":w | TestNearest<CR>")
vim.keymap.set("n", "<Leader>T", ":w | TestFile<CR>")
vim.keymap.set("n", "<Leader>a", ":w | TestSuite<CR>")
vim.keymap.set("n", "<Leader>l", ":w | TestLast<CR>")
vim.keymap.set("n", "<Leader>g", ":w | TestVisit<CR>")

vim.cmd('let test#strategy="dispatch"')
