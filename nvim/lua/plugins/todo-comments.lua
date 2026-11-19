return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "TODOs" },
    {
      "<leader>sT",
      function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,
      desc = "TODO/FIX only",
    },
  },
}
