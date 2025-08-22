return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    init = function()
      vim.g.autoformat = false
    end,
    opts = {
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              useLibraryCodeForTypes = true,
              diagnosticSeverityOverrides = {
                reportGeneralTypeIssues = "error",
                reportUndefinedVariable = "none",
              },
            },
          },
        },
      },
      cucumber_language_server = {
        settings = {
          cucumber = {
            features = { "cypress/e2e/**/*.feature" },
            glue = { "cypress/e2e/**/*.js" },
          },
        },
      },
      vtsls = {
        settings = {
          typescript = {
            preferences = {
              importModuleSpecifier = "relative",
            },
          },
        },
      },
    },
    -- opts = function(_, opts)
    --   opts.servers.pyright = vim.tbl_extend("force", opts.servers.pyright, {
    --     settings = {
    --       python = {
    --         analysis = {
    --           typeCheckingMode = "basic",
    --           useLibraryCodeForTypes = true,
    --           diagnosticSeverityOverrides = {
    --             reportGeneralTypeIssues = "error",
    --             reportUndefinedVariable = "none",
    --           },
    --         },
    --       },
    --     },
    --   })
    --
    --   opts.servers.cucumber_language_server = {
    --     settings = {
    --       cucumber = {
    --         features = { "cypress/e2e/**/*.feature" },
    --         glue = { "cypress/e2e/**/*.js" },
    --       },
    --     },
    --   }
    --
    --   opts.servers.vtsls = vim.tbl_extend("force", opts.servers.vtsls or {}, {
    --     settings = {
    --       typescript = {
    --         preferences = {
    --           importModuleSpecifier = "relative",
    --         },
    --       },
    --     },
    --   })
    -- end,
  },
}
