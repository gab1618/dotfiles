require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyser", "ts_ls", "svelte", "elixirls", "astro", "texlab" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  }
})
require('lspconfig').rust_analyzer.setup{}

require("lspconfig").ts_ls.setup{}

require("lspconfig").svelte.setup{}

require("lspconfig").astro.setup{}

require("lspconfig").texlab.setup{}
