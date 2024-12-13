return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    keys = {
      {
        "-",
        "<CMD>Oil<CR>",
        desc = "Oil",
      },
    },
    opts = {
      default_file_explorer = true,
      win_options = {
        signcolumn = "yes:2",
      },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },
  {
    "refractalize/oil-git-status.nvim",

    dependencies = {
      "stevearc/oil.nvim",
    },

    config = true,
  },
}
