return { -- one plugin spec
  "saghen/blink.cmp", -- the completion engine
  version = "1.*", -- stay on v1 releases, which ship a prebuilt Rust matcher
  event = { "InsertEnter", "CmdlineEnter" }, -- load when you start typing or open the : command line
  dependencies = { "rafamadriz/friendly-snippets" }, -- a large set of VS Code-format snippets (React, TS, ...)
  opts = { -- passed to require("blink.cmp").setup()
    keymap = { preset = "default" }, -- <C-y> accept; alternatives: "enter" (<CR>) or "super-tab" (<Tab>)
    appearance = { nerd_font_variant = "mono" }, -- icon spacing for "Nerd Font Mono" fonts
    completion = { -- menu behaviour
      documentation = { auto_show = true, auto_show_delay_ms = 200 }, -- docs panel appears after 200 ms on an item
    },
    signature = { enabled = true }, -- shows the function's parameters while you type arguments
    sources = { -- where suggestions come from
      default = { "lazydev", "lsp", "path", "snippets", "buffer" }, -- checked in this order; lazydev only does anything in Lua files
      providers = { -- defines the extra "lazydev" source used above
        lazydev = {
          name = "LazyDev", -- label shown in the menu
          module = "lazydev.integrations.blink", -- the code that provides it
          score_offset = 100, -- ranks its items above the rest
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }, -- use the fast Rust matcher; warn and fall back to Lua if it's missing
  },
  opts_extend = { "sources.default" }, -- other plugin files can append sources instead of replacing the list
}
