return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    opts = {
      enable_close = true, -- type <div> → get </div>
      enable_rename = true, -- rename the opening tag → closing tag follows
      enable_close_on_slash = true, -- type </ → the closing tag's name is filled in
    },
  },
}
