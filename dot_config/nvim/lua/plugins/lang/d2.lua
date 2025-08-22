return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters.d2 = {
        args = { "fmt", "-" },
      }
      for _, ft in ipairs({ "d2" }) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "d2")
      end
    end,
  },
}
