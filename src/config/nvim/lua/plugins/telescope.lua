return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files"},
    {"<leader>fo", "<cmd>Telescope live_grep<cr>", desc = "Grep string"},
    {"<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep string"},
    {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Search buffers"},
  },
}
