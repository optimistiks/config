return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  opts = {
    keymaps = {
      view = {
        toggle_explorer = "<leader>E", -- default <leader>b would collide with your <leader>b (buffer) group
      },
    },
  },
  keys = {
    { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "Diff: uncommitted changes" },
    { "<leader>gD", "<cmd>CodeDiff main...<cr>", desc = "Diff: branch vs main" },
    { "<leader>gf", "<cmd>CodeDiff history %<cr>", desc = "File history" },
    {
      "<leader>gm",
      function() vim.cmd("CodeDiff merge " .. vim.fn.fnameescape(vim.fn.expand("%:p"))) end,
      desc = "Resolve conflicts (this file)",
    },
  },
}
