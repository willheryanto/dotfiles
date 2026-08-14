return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "n",
      desc = "Format",
    },
    {
      "<leader>cf",
      function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "v",
      desc = "Format selection",
    },
  },
  opts = {
    formatters_by_ft = {
      -- Languages add their formatters here via opts_extend
      -- Example: lua = { "stylua" },
      sql = { lsp_format = "prefer" },
    },
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    },
  },
}
