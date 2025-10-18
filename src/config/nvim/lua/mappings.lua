local map = vim.keymap.set

map("i", "kj", "<ESC>")
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
