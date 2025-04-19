return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
      provider = "openai",
      openai = {
        model = "o3-mini",
        timeout = 30000, -- Timeout in milliseconds
        disable_tools = true,
        reasoning_effort = "high",
      },
      vendors = {
        ["deepseek"] = {
          __inherited_from = "openai",
          endpoint = "https://api.deepseek.com/v1",
          model = "deepseek-chat",
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0,
          max_tokens = 4096,
          api_key_name = "DEEPSEEK_API_KEY",
        },
        ["llama"] = {
          __inherited_from = "openai",
          endpoint = "https://api.kluster.ai/v1",
          model = "klusterai/Meta-Llama-3.1-8B-Instruct-Turbo",
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0,
          max_tokens = 4096,
          api_key_name = "KLUSTERAI_API_KEY",
        },
      },
      file_selector = {
        provider = "snacks",
      },
      windows = {
        edit = {
          start_insert = true,
        },
        ask = {
          start_insert = false,
        },
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      {
        "grapp-dev/nui-components.nvim",
        dependencies = {
          "MunifTanjim/nui.nvim",
        },
      },
      --- The below is optional, make sure to setup it properly if you have lazy=true
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = {
      "AiderTerminalToggle",
      "AiderHealth",
    },
    keys = {
      { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
      { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
      { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
      { "<leader>a+", "<cmd>Aider add<cr>", desc = "Add File" },
      { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Drop File" },
      { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
      -- Example nvim-tree.lua integration if needed
      { "<leader>a+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
      { "<leader>a-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    dependencies = {
      "folke/snacks.nvim",
    },
    name = "nvim_aider",
    opts = {
      args = {},
    },
  },
  -- {
  --   "ggml-org/llama.vim"
  -- }
  -- {
  --   "olimorris/codecompanion.nvim",
  --   opts = {
  --     adapters = {
  --       deepseek = {
  --         schema = {
  --           model = "deepseek-chat",
  --         },
  --       },
  --     },
  --     strategies = {
  --       chat = {
  --         adapter = "deepseek",
  --       },
  --       inline = {
  --         adapter = "deepseek",
  --       },
  --     },
  --   },
  -- },
}
