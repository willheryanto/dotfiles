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
      { "<leader>a/", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider" },
      { "<leader>as", "<cmd>AiderTerminalSend<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>AiderQuickSendCommand<cr>", desc = "Send Command To Aider" },
      { "<leader>ab", "<cmd>AiderQuickSendBuffer<cr>", desc = "Send Buffer To Aider" },
      { "<leader>a+", "<cmd>AiderQuickAddFile<cr>", desc = "Add File to Aider" },
      { "<leader>a-", "<cmd>AiderQuickDropFile<cr>", desc = "Drop File from Aider" },
      { "<leader>ar", "<cmd>AiderQuickReadOnlyFile<cr>", desc = "Add File as Read-Only" },
      -- Example nvim-tree.lua integration if needed
      { "<leader>a+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
      { "<leader>a-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    dependencies = {
      "folke/snacks.nvim",
    },
    name = "nvim_aider",
    opts = {
      args = {
        "--edit-format diff",
        "--architect",
        "--model o3-mini",
        "--reasoning-effort high",
        "--editor-model deepseek/deepseek-chat",
      },
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
