return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.sqlfluff.with({
          filetypes = { "sql", "dbt" },
        }),
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = vim.list_extend(opts.linters_by_ft or {}, {
        sql = { "sqlfluff" },
        dbt = { "sqlfluff" },
      })
    end,
  },
}
