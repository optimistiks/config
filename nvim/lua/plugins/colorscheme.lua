return {
  "folke/tokyonight.nvim",
  lazy = false, -- the colorscheme must load at startup
  priority = 1000, -- before every other plugin, so they pick up its colours
  opts = { style = "night" }, -- also: "storm", "moon", "day"
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
