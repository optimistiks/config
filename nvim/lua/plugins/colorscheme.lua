return {
  "RazikSF/lumina-themes",
  lazy = false,
  priority = 1000,
  init = function()
    -- Re-apply after any colorscheme loads, so the fix survives light/dark switches
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Comment" })
        vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "Comment" })
      end,
    })
  end,
  config = function()
    local function apply()
      local name = vim.o.background == "light" and "lumina-cherenkov-light" or "lumina-vitrail-dark"
      if vim.g.colors_name ~= name then vim.cmd.colorscheme(name) end
    end
    apply()
    -- Neovim updates 'background' when Ghostty reports a light/dark switch
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      nested = true, -- let the colorscheme switch fire its own ColorScheme event
      callback = apply,
    })
  end,
}
