return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  opts = {
    linters_by_ft = {
      -- Languages add their linters here
      -- Example: lua = { "selene" },
    },
    -- Custom linter overrides
    linters = {},
  },
  config = function(_, opts)
    local lint = require("lint")

    lint.linters_by_ft = opts.linters_by_ft or {}

    -- Apply custom linter configs
    for name, config in pairs(opts.linters or {}) do
      if type(config) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], config)
      end
    end

    -- Lint on events
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        if vim.bo.buftype == "" then
          lint.try_lint()
        end
      end,
    })
  end,
}
