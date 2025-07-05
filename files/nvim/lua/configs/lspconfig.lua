require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyser" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

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
