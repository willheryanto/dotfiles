-- HTTP client plugins
return {
  -- Treesitter for HTTP files
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "http", "graphql" },
    },
  },

  -- Kulala: HTTP client for .http files
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<leader>rr", function() require("kulala").run() end, desc = "Run request" },
      { "<leader>ra", function() require("kulala").run_all() end, desc = "Run all requests" },
      { "<leader>rp", function() require("kulala").jump_prev() end, desc = "Previous request" },
      { "<leader>rn", function() require("kulala").jump_next() end, desc = "Next request" },
      { "<leader>ri", function() require("kulala").inspect() end, desc = "Inspect response" },
      { "<leader>ry", function() require("kulala").copy() end, desc = "Copy as cURL" },
      { "<leader>rt", function() require("kulala").toggle_view() end, desc = "Toggle body/headers" },
    },
    opts = {
      split_direction = "vertical",
      default_view = "body",
    },
  },

  -- Curl: Adhoc curl requests
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen", "CurlClose" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>rc", "<cmd>CurlOpen<cr>", desc = "Open Curl scratchpad" },
      { "<leader>rC", "<cmd>CurlClose<cr>", desc = "Close Curl" },
    },
    opts = {},
  },
}
