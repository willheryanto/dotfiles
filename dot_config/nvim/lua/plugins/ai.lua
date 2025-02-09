return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
      provider = "openai",
      gemini = {
        model = "gemini-exp-1206",
        -- model = "gemini-2.0-flash-thinking-1219",
        temperature = 0,
        -- max_tokens = 8192,
      },
      openai = {
        model = "o1-mini",
        timeout = 30000, -- Timeout in milliseconds
        disable_tools = true,
        temperature = 0,
        max_tokens = 4096,
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
