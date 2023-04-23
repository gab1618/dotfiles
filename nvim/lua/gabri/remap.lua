vim.g.mapleader = " ";

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex);
vim.keymap.set("i", "kj", "<esc>");
vim.keymap.set("i", "jk", "<esc>");

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<C-a>", ":bp<CR>")
