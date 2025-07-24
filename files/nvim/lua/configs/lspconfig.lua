require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyser", "ts_ls", "svelte", "elixirls", "astro" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

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

