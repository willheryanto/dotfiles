-- Config file formats: JSON, YAML, TOML, dotenv, etc.

local function setup_lsps()
  -- JSON LSP with schema support
  vim.lsp.config("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
    settings = {
      json = {
        validate = { enable = true },
        schemas = require("schemastore").json.schemas(),
      },
    },
  })

  -- YAML LSP with schema support
  vim.lsp.config("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_markers = { ".git" },
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" },
        schemas = require("schemastore").yaml.schemas(),
        validate = true,
        keyOrdering = false,
      },
    },
  })

  -- TOML LSP
  vim.lsp.config("taplo", {
    cmd = { "taplo", "lsp", "stdio" },
    filetypes = { "toml" },
    root_markers = { ".git" },
  })

  vim.lsp.enable("jsonls")
  vim.lsp.enable("yamlls")
  vim.lsp.enable("taplo")
end

return {
  -- SchemaStore for JSON/YAML schemas
  {
    "b0o/SchemaStore.nvim",
    lazy = false,
    version = false,
    config = function()
      setup_lsps()
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "json",
        "json5",
        "yaml",
        "toml",
        "dockerfile",
        "ini",
        "xml",
        "graphql",
        "csv",
        "tsv",
      },
    },
  },

  -- Formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
        graphql = { "prettier" },
      },
    },
  },
}
