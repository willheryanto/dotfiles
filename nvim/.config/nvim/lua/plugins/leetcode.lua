return {
  -- Treesitter html parser (required for leetcode description)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "html" },
    },
  },

  -- LeetCode
  {
    "kawre/leetcode.nvim",
    lazy = false, -- Must load on startup for :Leet command
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "python3", -- Default language
      cn = {
        enabled = false, -- Use leetcode.com (not cn)
      },
      storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
      },
      injector = {
        -- Inject imports that won't be submitted
        ["typescript"] = {
          before = true, -- Use default imports
        },
        ["python3"] = {
          before = true,
        },
      },
    },
    keys = {
      { "<leader>ll", "<cmd>Leet<cr>", desc = "LeetCode Menu" },
      { "<leader>ld", "<cmd>Leet desc toggle<cr>", desc = "Toggle Description" },
      { "<leader>lr", "<cmd>Leet run<cr>", desc = "Run Tests" },
      { "<leader>ls", "<cmd>Leet submit<cr>", desc = "Submit Solution" },
      { "<leader>lc", "<cmd>Leet console<cr>", desc = "Console" },
      { "<leader>li", "<cmd>Leet info<cr>", desc = "Problem Info" },
      { "<leader>lL", "<cmd>Leet list<cr>", desc = "Problem List" },
    },
  },
}
