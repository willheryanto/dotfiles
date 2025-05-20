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
        ["<C-l>"] = false, -- Unbind refresh from Ctrl+L
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
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      {
        -- Open in the current working directory
        "<leader>fe",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>fE",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      { "<leader>e", "<leader>fe", desc = "Yazi (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Yazi (cwd)", remap = true },
    },
    opts = {},
  },
}
