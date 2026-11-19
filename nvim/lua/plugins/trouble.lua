return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "TODOs" },
    { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols outline" },
  },
}
