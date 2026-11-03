return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = { enabled = true },
    bigfile = { enabled = true }, -- switches off heavy features for huge files
    quickfile = { enabled = true }, -- shows `nvim file.tsx` before plugins finish loading
    explorer = { enabled = true }, -- replaces netrw: `nvim .` opens the explorer
    indent = { enabled = true }, -- indent guides + current-scope highlight
    input = { enabled = true }, -- nicer vim.ui.input (used by LSP rename etc.)
    notifier = { enabled = true, timeout = 3000 },
    words = { enabled = true }, -- highlights LSP references of the word under cursor
    picker = {
      enabled = true,
      sources = {
        explorer = { hidden = true }, -- show dotfiles like .env, .eslintrc
        files = { hidden = true },
        grep = { regex = false }, -- literal by default; <A-r> toggles regex
      },
      win = {
        input = {
          keys = {
            ["<A-k>"] = { "history_back", mode = { "i", "n" } },
            ["<A-j>"] = { "history_forward", mode = { "i", "n" } },
          },
        },
      },
    },
    lazygit = {},
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    scroll = { enabled = true }, -- remove if it feels sluggish
    image = { enabled = true }, -- needs Kitty/Ghostty/WezTerm
    scratch = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    -- Explorer
    {
      "<leader>e",
      function() Snacks.explorer() end,
      desc = "Explorer",
    },

    -- Find
    {
      "<leader><space>",
      function() Snacks.picker.smart() end,
      desc = "Smart find files",
    },
    {
      "<leader>ff",
      function() Snacks.picker.files() end,
      desc = "Files",
    },
    {
      "<leader>fr",
      function() Snacks.picker.recent() end,
      desc = "Recent files",
    },
    {
      "<leader>fb",
      function() Snacks.picker.buffers() end,
      desc = "Buffers",
    },

    -- Search
    {
      "<leader>/",
      function() Snacks.picker.grep() end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function() Snacks.picker.grep_word() end,
      desc = "Grep word",
      mode = { "n", "x" },
    },
    {
      "<leader>sb",
      function() Snacks.picker.lines() end,
      desc = "Buffer lines",
    },
    {
      "<leader>sd",
      function() Snacks.picker.diagnostics() end,
      desc = "Diagnostics",
    },
    {
      "<leader>sk",
      function() Snacks.picker.keymaps() end,
      desc = "Keymaps",
    },
    {
      "<leader>sh",
      function() Snacks.picker.help() end,
      desc = "Help",
    },
    {
      "<leader>'",
      function() Snacks.picker.resume() end,
      desc = "Resume last picker",
    },

    -- LSP
    {
      "gd",
      function() Snacks.picker.lsp_definitions() end,
      desc = "Definition",
    },
    {
      "grr",
      function() Snacks.picker.lsp_references() end,
      desc = "References",
    },
    {
      "gri",
      function() Snacks.picker.lsp_implementations() end,
      desc = "Implementation",
    },
    {
      "grt",
      function() Snacks.picker.lsp_type_definitions() end,
      desc = "Type definition",
    },
    {
      "<leader>ss",
      function() Snacks.picker.lsp_symbols() end,
      desc = "Symbols (file)",
    },
    {
      "gO",
      function() Snacks.picker.lsp_symbols() end,
      desc = "Document symbols",
    },
    {
      "<leader>sS",
      function() Snacks.picker.lsp_workspace_symbols() end,
      desc = "Symbols (workspace)",
    },
    {
      "]]",
      function() Snacks.words.jump(vim.v.count1) end,
      desc = "Next reference",
    },
    {
      "[[",
      function() Snacks.words.jump(-vim.v.count1) end,
      desc = "Prev reference",
    },

    -- Git
    {
      "<leader>gg",
      function() Snacks.lazygit() end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function() Snacks.lazygit.log_file() end,
      desc = "Lazygit file history",
    },
    {
      "<leader>gs",
      function() Snacks.picker.git_status() end,
      desc = "Git status",
    },
    {
      "<leader>gB",
      function() Snacks.gitbrowse() end,
      desc = "Open on GitHub",
      mode = { "n", "v" },
    },

    -- Notifications
    {
      "<leader>n",
      function() Snacks.picker.notifications() end,
      desc = "Notification history",
    },
    {
      "<leader>un",
      function() Snacks.notifier.hide() end,
      desc = "Dismiss notifications",
    },

    -- Buffers
    {
      "<leader>bd",
      function() Snacks.bufdelete() end,
      desc = "Delete buffer (keep layout)",
    },

    -- Misc
    -- { "<C-/>", function() Snacks.terminal() end, desc = "Toggle terminal", mode = { "n", "t" } },
    {
      "<leader>.",
      function() Snacks.scratch() end,
      desc = "Scratch buffer",
    },
    {
      "<leader>S",
      function() Snacks.scratch.select() end,
      desc = "Pick scratch buffer",
    },
    {
      "<leader>z",
      function() Snacks.zen() end,
      desc = "Zen mode",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- On/off toggles under <leader>u ("UI")
        Snacks.toggle.option("wrap"):map("<leader>uw")
        Snacks.toggle.option("relativenumber"):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle({
          name = "Format on save",
          get = function() return vim.g.autoformat ~= false end,
          set = function(state) vim.g.autoformat = state end,
        }):map("<leader>uf")
        Snacks.toggle({
          name = "ESLint fix on save",
          get = function() return vim.g.eslint_fix ~= false end,
          set = function(state) vim.g.eslint_fix = state end,
        }):map("<leader>ue")
        Snacks.toggle({
          name = "Inline blame",
          get = function() return require("gitsigns.config").config.current_line_blame end,
          set = function(state) require("gitsigns").toggle_current_line_blame(state) end,
        }):map("<leader>ub")
      end,
    })
  end,
}
