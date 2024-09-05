return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "guivazcabral/neotest-jest",
    },
    opts = function(_, opts)
      opts.adapters = vim.tbl_extend("force", opts.adapters, {
        require("neotest-jest")({
          -- jestCommand = "npm run test:single -- --selectProjects product-transactions",
          jestCommand = "node --expose-gc --no-compilation-cache ./node_modules/jest/bin/jest.js --logHeapUsage --colors --silent",
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
