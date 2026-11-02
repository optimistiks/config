return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc }) end

      -- Navigate
      map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
      map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")

      -- Act on the hunk under the cursor
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview hunk")
      map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage / unstage hunk")
      map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")

      -- Whole file
      map("n", "<leader>ghS", gs.stage_buffer, "Stage file")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset file")
      map("n", "<leader>ghd", gs.diffthis, "Diff file vs last commit")

      -- Blame
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame line")
      map("n", "<leader>ghB", gs.blame, "Blame file")

      -- Text object: "ih" = inner hunk (e.g. vih selects the hunk, dih deletes it)
      map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
    end,
  },
}
