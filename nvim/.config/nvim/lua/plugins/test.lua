-- Testing: neotest with Jest
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Jest adapter
      "nvim-neotest/neotest-jest",
    },
    keys = {
      { "<leader>Tt", function() require("neotest").run.run() end, desc = "Run Nearest Test" },
      { "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File Tests" },
      { "<leader>TT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Tests" },
      { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Run Last Test" },
      { "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>TS", function() require("neotest").run.stop() end, desc = "Stop Test" },
      { "<leader>Tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
      { "<leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest Test" },
      { "<leader>TD", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, desc = "Debug File Tests" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = function()
              local cwd = vim.fn.getcwd()
              local jest_bin = cwd .. "/node_modules/.bin/jest"
              if vim.fn.filereadable(jest_bin) == 1 then
                return jest_bin
              end
              -- Fallback for monorepo: search upward for node_modules
              local root = vim.fn.finddir("node_modules", cwd .. ";")
              if root ~= "" then
                return vim.fn.fnamemodify(root, ":p") .. ".bin/jest"
              end
              return "jest" -- Global fallback
            end,
            jestConfigFile = function()
              local cwd = vim.fn.getcwd()
              -- Check for common jest config files
              for _, config in ipairs({ "jest.config.ts", "jest.config.js", "jest.config.mjs" }) do
                if vim.fn.filereadable(cwd .. "/" .. config) == 1 then
                  return config
                end
              end
              return "jest.config.js"
            end,
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
      })
    end,
  },
}
