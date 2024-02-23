return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>go", ":Octo ", { desc = "Octo" } },
    },
    opts = {},
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    keys = {
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
