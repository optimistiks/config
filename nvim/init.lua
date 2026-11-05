-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
vim.opt.autoread = true -- reload files changed outside Neovim (if you have no unsaved edits)
require("vim._core.ui2").enable({ msg = { target = "msg" } }) -- experimental 0.12 message UI: no "Press ENTER" interruptions
-- vim.opt.updatetime = 200
-- vim.opt.timeoutlen = 300

-- Disable S so vim doesn't wait and mini can take over S
vim.keymap.set({ "n", "x" }, "s", "<Nop>")

-- Copy file path (absolute, relative, file name)

vim.keymap.set("n", "<leader>yr", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy relative path" })

vim.keymap.set("n", "<leader>ya", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy absolute path" })

vim.keymap.set("n", "<leader>yf", function()
  local name = vim.fn.expand("%:t")
  vim.fn.setreg("+", name)
  vim.notify("Copied: " .. name)
end, { desc = "Copy file name" })

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check for files changed outside Neovim",
  callback = function()
    if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
  end,
})

--[[
-- https://github.com/vscode-neovim/vscode-neovim/issues/2117
if vim.g.vscode then
  -- Workaround for vscode-neovim UI desync (issue #2117)

  -- 1. Redraw on CursorHold (idle for some time)
  local redraw_fix = vim.api.nvim_create_augroup('VSCodeRedrawFix', { clear = true })
  vim.api.nvim_create_autocmd('CursorHold', {
    group = redraw_fix,
    callback = function()
      vim.cmd('silent! mode')  -- triggers a lightweight redraw
    end,
  })

  -- 2. Redraw immediately after text changes (e.g., visual delete)
  local redraw_group = vim.api.nvim_create_augroup('RedrawOnDelete', { clear = true })
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    group = redraw_group,
    callback = function()
      if vim.fn.mode() == 'n' then
        vim.cmd('silent! mode')  -- refresh UI after delete/insert
      end
    end,
  })
end
]]

-- PLUGIN MANAGER

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- require("config.options")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- loads every file in lua/plugins/
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- require("config.keymaps")

-- :w always creates any missing folders
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Create missing parent directories on save",
  callback = function(ev)
    if ev.match:match("^%w%w+:[\\/][\\/]") then return end -- skip URLs like oil://
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
