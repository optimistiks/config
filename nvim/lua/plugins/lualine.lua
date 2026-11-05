return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function() vim.opt.showmode = false end, -- lualine shows the mode, so hide Vim's "-- INSERT --"
  opts = {
    options = {
      theme = "auto", -- picks up tokyonight's lualine theme automatically
      globalstatus = true, -- one statusline across the bottom, not one per split
      disabled_filetypes = { statusline = { "snacks_dashboard" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        { "b:gitsigns_head", icon = "" },
        {
          "diff", -- +added ~changed -removed, taken from gitsigns
          source = function()
            local g = vim.b.gitsigns_status_dict
            if g then return { added = g.added, modified = g.changed, removed = g.removed } end
          end,
        },
      },
      lualine_c = {
        { "filename", path = 1 }, -- path relative to the project root
        "diagnostics",
      },
      lualine_x = {
        { -- shows when lazy.nvim has plugin updates available
          function() return require("lazy.status").updates() end,
          cond = function() return require("lazy.status").has_updates() end,
        },
        "lsp_status", -- attached language servers, spinner while they're busy
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
