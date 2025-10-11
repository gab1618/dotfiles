local servers = { "lua_ls", "html", "cssls", "rust_analyser", "ts_ls", "svelte", "elixirls", "astro", "texlab" }
vim.lsp.enable(servers)

vim.lsp.config("rust_analyzer", {})

vim.lsp.config("ts_ls", {})

vim.lsp.config("svelte", {})

vim.lsp.config("astro", {})

vim.lsp.config("texlab", {})

vim.lsp.config("lua_ls", {})

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set("n", "gd", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "ds", vim.diagnostic.setloclist, { desc = "Go to implementation" })
