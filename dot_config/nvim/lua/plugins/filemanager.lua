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
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-r>"] = "actions.refresh", -- Bind refresh to Ctrl+R
        ["<C-l>"] = false,             -- Unbind refresh from Ctrl+L
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
