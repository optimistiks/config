return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  opts = { max_lines = 3, multiline_threshold = 1 },
  keys = {
    { "gC", function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = "Go to context" },
  },
}
