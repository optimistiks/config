return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts)
    -- Non-LSP tools to keep installed (formatters, linters, debuggers)
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, tool in ipairs({ "prettier", "prettierd", "stylua" }) do
        local pkg = registry.get_package(tool)
        if not pkg:is_installed() then pkg:install() end
      end
    end)
  end,
}
