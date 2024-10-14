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
        ":DiffviewOpen<CR>",
        desc = "Open diffview",
      },
      {
        "<leader>gdc",
        ":DiffviewClose<CR> ",
        desc = "Close diffview",
      },
      {
        "<leader>gdh",
        ":DiffviewFileHistory %<CR> ",
        desc = "Open diffview of current file history",
      },
    },
    opts = {},
  },
}
