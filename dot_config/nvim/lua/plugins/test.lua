return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "guivazcabral/neotest-jest",
    },
    opts = function(_, opts)
      opts.adapters = vim.tbl_extend("force", opts.adapters, {
        require("neotest-jest")({
          jestCommand = "npm run test:all --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      })
    end,
  },
}
