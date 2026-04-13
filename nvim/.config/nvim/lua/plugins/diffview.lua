-- Diffview: Git diff viewer and merge tool
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gvo", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gvc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>gvf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
    { "<leader>gvh", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
      },
    },
    file_panel = {
      win_config = {
        position = "left",
        width = 35,
      },
    },
  },
}
