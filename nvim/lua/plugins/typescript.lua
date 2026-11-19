local ts_fts = { "typescript", "typescriptreact", "javascript", "javascriptreact" }

return {
  -- Correct comment style per position: {/* */} inside JSX markup, // in code
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },

  -- Rewrites cryptic TypeScript errors in plain English, inside the diagnostics themselves
  { "dmmulroy/ts-error-translator.nvim", ft = ts_fts, opts = {} },

  -- Type-checks the whole project with the project's own tsc; results go to Trouble
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC", "TSCStop", "TSCOpen", "TSCClose" },
    opts = { use_trouble_qflist = true },
    keys = { { "<leader>ct", "<cmd>TSC<cr>", desc = "Type-check project (tsc)" } },
  },
}
