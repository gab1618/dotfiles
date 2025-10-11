local servers = { "lua_ls", "html", "cssls", "rust_analyser", "ts_ls", "svelte", "elixirls", "astro", "texlab" }
vim.lsp.enable(servers)

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })

vim.lsp.config("rust_analyzer", {})

vim.lsp.config("ts_ls", {})

vim.lsp.config("svelte", {})

vim.lsp.config("astro", {})

vim.lsp.config("texlab", {})

vim.lsp.config("lua_ls", {})
