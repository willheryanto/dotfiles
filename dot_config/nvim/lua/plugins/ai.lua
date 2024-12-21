return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
      provider = "copilot",
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-exp-1206",
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
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
