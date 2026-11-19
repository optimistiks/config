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

    -- Ask macOS directly, in case a switch happened while the laptop slept
    local function sync_with_macos()
      vim.system({ "defaults", "read", "-g", "AppleInterfaceStyle" }, { text = true }, function(res)
        local bg = (res.code == 0 and res.stdout:match("Dark")) and "dark" or "light"
        vim.schedule(function()
          if vim.o.background ~= bg then vim.o.background = bg end -- triggers the OptionSet → theme switch
        end)
      end)
    end

    vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, { callback = sync_with_macos })
    vim.uv.new_timer():start(30000, 30000, vim.schedule_wrap(sync_with_macos)) -- every 30 s as a safety net
  end,
}
