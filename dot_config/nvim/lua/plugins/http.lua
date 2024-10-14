return {
  {
    "rest-nvim/rest.nvim",
    keys = {
      { "<leader>R", "", desc = "+Rest" },
      { "<leader>RS", "<cmd>Rest run<cr>", desc = "Request" },
      { "<leader>RR", ":Rest run ", desc = "Request with argument" },
      { "<leader>RL", "<cmd>Rest last<cr>", desc = "Send the last request" },
      { "<leader>RO", "<cmd>Rest open<cr>", desc = "Open request under the cursor" },
    },
  },
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },
}
