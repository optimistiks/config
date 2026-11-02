return {
  "romus204/tree-sitter-manager.nvim",
  lazy = false, -- must be ready before the first file opens
  opts = {
    ensure_installed = {
      "typescript",
      "tsx",
      "javascript",
      "jsdoc",
      "css",
      "scss",
      "html",
      "json",
      "regex",
      "bash",
    },
  },
}
