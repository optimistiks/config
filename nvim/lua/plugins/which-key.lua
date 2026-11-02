return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix", -- compact popup in the bottom-right; try "modern" or "classic"
    delay = 300, -- ms before the popup appears
    spec = {
      { "<leader>c", group = "code" },
      { "<leader>f", group = "find" },
      { "<leader>s", group = "search" },
      { "<leader>g", group = "git" },
      { "<leader>u", group = "ui toggles" },
      { "<leader>b", group = "buffer" },
      { "<leader>gh", group = "hunks" },
      { "s", group = "surround" },
      { "gr", group = "lsp" },
      { "[", group = "prev" },
      { "]", group = "next" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Keymaps for this buffer",
    },
  },
}
