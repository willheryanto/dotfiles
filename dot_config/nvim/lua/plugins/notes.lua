return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "~/vaults/work",
        },
        {
          name = "personal",
          path = "~/vaults/personal",
        }
      },

      -- see below for full list of options 👇
    },

    keys = {
      { "<leader>o", "", desc = "+Obsidian", mode = { "n", "v" } },
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find by id" },
      { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Create / open daily note" },
      { "<leader>oO", "<cmd>ObsidianOpen<cr>", desc = "Open in app" },
      { "<leader>ow", "<cmd>ObsidianWorkspace<cr>", desc = "Workspace" },
      { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "Paste Image" },
      { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename" },
      { "<leader>oc", "<cmd>ObsidianToogleCheckbox<cr>", desc = "Toggle checkbox" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search" },
      { "<leader>ox", "<cmd>ObsidianExtractNote<cr>", desc = "Extract text into new note" },

      { "<leader>ol", "", desc = "+Links" },
      { "<leader>oln", "<cmd>ObsidianLinkNew<cr>", desc = "Create link", mode = { "n", "v" } },
      { "<leader>olg", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
      { "<leader>olb", "<cmd>ObsidianBacklinks<cr>", desc = "Pick links" },
      { "<leader>oll", "<cmd>ObsidianLinks<cr>", desc = "Extract links from buffer" },
    },
  },
}
