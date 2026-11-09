return {
  "RazikSF/lumina-themes",
  lazy = false,
  priority = 1000,
  -- for ghostty: https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/ghostty/Lumina%20Vitrail%20Dark
  config = function() vim.cmd.colorscheme("lumina-vitrail-dark") end,
}
