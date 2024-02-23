return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    init = function()
      vim.g.autoformat = false
    end,
    opts = function(_, opts)
      opts.servers.pyright = vim.tbl_extend("force", opts.servers.pyright, {
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
      })
    end,
  },
}
