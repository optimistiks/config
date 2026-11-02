return {
  -- Auto-close brackets and quotes
  { "nvim-mini/mini.pairs", event = "InsertEnter", opts = {} },

  -- Surround: add / delete / replace quotes, brackets, tags
  { "nvim-mini/mini.surround", event = "VeryLazy", opts = {} },

  -- Better text objects: tags, arguments, any quote, any bracket, next/last
  { "nvim-mini/mini.ai", event = "VeryLazy", opts = { n_lines = 500 } },
}
