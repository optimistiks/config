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
        {
          "b:gitsigns_head",
          icon = "",
          fmt = function(s) return #s > 20 and s:sub(1, 19) .. "…" or s end, -- truncate long branch names
        },
        {
          "diff",
          source = function()
            local g = vim.b.gitsigns_status_dict
            if g then return { added = g.added, modified = g.changed, removed = g.removed } end
          end,
        },
      },
      lualine_c = {
        { "filename", path = 4 }, -- parent folder + file: ui/OpportunityTableRow.tsx
        "diagnostics",
      },
      lualine_x = {
        { -- "recording @q" while recording a macro
          function() return "recording @" .. vim.fn.reg_recording() end,
          cond = function() return vim.fn.reg_recording() ~= "" end,
        },
        {
          function() return require("lazy.status").updates() end,
          cond = function() return require("lazy.status").has_updates() end,
        },
        "lsp_status",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
