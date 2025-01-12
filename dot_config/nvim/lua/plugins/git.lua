return {
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<leader>gd",
        "",
        desc = "+Git diff",
      },
      {
        "<leader>gdo",
        "<cmd>DiffviewOpen<CR>",
        desc = "Open diffview",
      },
      {
        "<leader>gdc",
        "<cmd>DiffviewClose<CR> ",
        desc = "Close diffview",
      },
      {
        "<leader>gdh",
        "<cmd>DiffviewFileHistory %<CR> ",
        desc = "Open diffview of current file history",
      },
    },
    opts = {},
  },
}
