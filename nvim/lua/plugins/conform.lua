local prettier = { "prettier", "prettier_global" }

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function() require("conform").format() end,
      mode = { "n", "x" },
      desc = "Format",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      json = prettier,
      jsonc = prettier,
      css = prettier,
      scss = prettier,
      html = prettier,
      markdown = prettier,
      yaml = prettier,
      lua = { "stylua" },
    },
    formatters = {
      prettier = { require_cwd = true }, -- only in projects with a Prettier config
      prettier_global = { -- Prettier defaults, only outside JS projects
        inherit = "prettier",
        condition = function(_, ctx) return not vim.fs.root(ctx.dirname, "package.json") end, -- do not run in JS projects where Prettier isn't set up
      },
    },
    format_on_save = function()
      if vim.g.autoformat == false then return end
      return { timeout_ms = 3000, lsp_format = "never" }
    end,
  },
}
