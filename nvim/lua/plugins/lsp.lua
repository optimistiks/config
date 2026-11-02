return { -- a plugin file returns a list of plugin specs
  { -- spec 1: nvim-lspconfig (the LSP hub)
    "neovim/nvim-lspconfig", -- provides ready-made configs for 300+ servers
    event = { "BufReadPre", "BufNewFile" }, -- load only when you open or create a file, not at startup
    dependencies = { -- loaded before lspconfig
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim", -- connects Mason (installs) to lspconfig (configs)
      "b0o/SchemaStore.nvim", -- a catalog of JSON schemas (package.json, tsconfig, ...)
    },
    config = function() -- runs once, after the plugin and its dependencies load
      vim.o.winborder = "rounded" -- rounded borders on all floats (hover, signature, diagnostics)

      vim.diagnostic.config({ -- how errors and warnings are displayed
        severity_sort = true, -- errors drawn on top of warnings on the same line
        virtual_text = { spacing = 2, source = "if_many" }, -- inline message at line end; names the source if several servers report
        float = { source = "if_many" }, -- same source labelling in the <C-w>d float
      })

      vim.lsp.config("*", { -- "*" = settings applied to every server
        capabilities = require("blink.cmp").get_lsp_capabilities(), -- tells servers blink supports snippets, auto-imports, etc.
      }) -- the require() also loads blink early, so this always works

      vim.lsp.config("vtsls", { -- extra settings for the TypeScript server
        settings = { -- passed to the server as-is
          vtsls = { -- settings for vtsls itself
            autoUseWorkspaceTsdk = true, -- use the project's node_modules TypeScript, not a bundled one
            experimental = { completion = { enableServerSideFuzzyMatch = true } }, -- server filters huge completion lists before sending them
          },
          typescript = { -- same options as VS Code's "typescript.*" settings
            updateImportsOnFileMove = { enabled = "always" }, -- rename/move a file → imports update, no prompt
            inlayHints = { -- grey hints in code; toggle with <leader>uh
              parameterNames = { enabled = "literals" }, -- fn(/*name:*/ 5), only for literal arguments
              parameterTypes = { enabled = true }, -- types of untyped callback parameters
              propertyDeclarationTypes = { enabled = true }, -- inferred types of class properties
              functionLikeReturnTypes = { enabled = true }, -- inferred return types
              enumMemberValues = { enabled = true }, -- numeric values of enum members
            },
          },
          javascript = { -- same, for .js/.jsx files
            updateImportsOnFileMove = { enabled = "always" }, -- update imports on move in JS too
          },
        },
      })

      vim.lsp.config("jsonls", { -- extra settings for the JSON server
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(), -- attach the right schema to package.json, tsconfig.json, ...
            validate = { enable = true }, -- report schema errors as diagnostics
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", { -- runs each time a server attaches to a buffer
        callback = function(ev)
          vim.keymap.set(
            "n",
            "K",
            function() vim.lsp.buf.hover({ max_width = 90, max_height = 25 }) end,
            { buffer = ev.buf, desc = "Hover" }
          ) -- buffer-local, so it replaces Neovim's default K
        end,
      })

      require("mason-lspconfig").setup({ -- installs and turns on the servers
        ensure_installed = { -- installed automatically if missing
          "vtsls", -- TypeScript / JavaScript
          "eslint", -- ESLint diagnostics + fix code actions (uses the project's eslint)
          "tailwindcss", -- class completion; only attaches if a Tailwind config exists
          "cssls", -- CSS / SCSS / Less
          "html", -- HTML
          "jsonls", -- JSON (+ the schemas above)
          "lua_ls", -- Lua, for editing this config
        },
      }) -- every installed server is enabled automatically (automatic_enable)
    end,
  },

  { -- spec 2: lazydev (Lua help for your config)
    "folke/lazydev.nvim", -- tells lua_ls about Neovim's API and your plugins
    ft = "lua", -- load only when a .lua file is opened
    opts = {
      library = { -- extra type definitions, loaded only when used
        { path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- types for vim.uv when your code uses it
        { path = "snacks.nvim", words = { "Snacks" } }, -- types for Snacks.* when your code mentions Snacks
      },
    },
  },
}
