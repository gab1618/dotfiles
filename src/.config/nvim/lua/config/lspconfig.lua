local servers = { "lua_ls", "html", "cssls", "rust_analyser", "ts_ls", "svelte", "elixirls", "astro", "texlab" }
vim.lsp.enable(servers)

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config("rust_analyzer", { capabilities = capabilities })

vim.lsp.config("ts_ls", { capabilities = capabilities })

vim.lsp.config("svelte", { capabilities = capabilities })

vim.lsp.config("astro", { capabilities = capabilities })

vim.lsp.config("texlab", { capabilities = capabilities })

vim.lsp.config("lua_ls", { capabilities = capabilities })

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code action" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "See diagnostic list" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "See references" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "gd", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
