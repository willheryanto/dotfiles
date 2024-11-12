return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "guivazcabral/neotest-jest",
      commit = "c2118446d770fedb360a91b1d91a7025db86d4f1"
    },
    opts = function(_, opts)
      opts.adapters = vim.tbl_extend("force", opts.adapters, {
        require("neotest-jest")({
          -- jestCommand = "node --expose-gc --no-compilation-cache ./node_modules/jest/bin/jest.js --logHeapUsage --colors --silent",
          -- jestCommand = "npm run jest",
          jestCommand = function()
            local project = vim.fn.input({
              prompt = "Command: ",
              completion = "file",
            })

            if project == "" then
              return "npm run jest"
            end
            return "npm run jest -- --selectProjects " .. project
          end,
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
          strategy_config = function(default_strategy, _)
            default_strategy["resolveSourceMapLocations"] = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            }
            return default_strategy
          end,
        }),
      })
    end,
  },
}
