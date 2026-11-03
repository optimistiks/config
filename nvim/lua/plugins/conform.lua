local prettier = { "prettierd", "prettier_global" }

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
      prettierd = { require_cwd = true }, -- same "only with a project config" rule
      prettier_global = { -- Prettier defaults, only outside JS projects
        inherit = "prettier",
        condition = function(_, ctx) return not vim.fs.root(ctx.dirname, "package.json") end, -- do not run in JS projects where Prettier isn't set up
      },
    },
    format_on_save = function(bufnr)
      if vim.g.autoformat == false then return end
      -- ESLint fix-all first (only where the ESLint server is attached), then Prettier
      if vim.g.eslint_fix ~= false and #vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" }) > 0 then
        vim.api.nvim_buf_call(bufnr, function() vim.cmd("LspEslintFixAll") end)
      end
      return { timeout_ms = 3000, lsp_format = "never" }
    end,
  },
}
