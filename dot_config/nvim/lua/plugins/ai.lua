return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
      provider = "gemini",
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        -- model = "gemini-exp-1206",
        model = "gemini-2.0-flash-thinking-1219",
        temperature = 0,
        max_tokens = 8192,
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
}
