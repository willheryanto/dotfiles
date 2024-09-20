return {
  { "folke/noice.nvim", enabled = true, commit = "d9328ef903168b6f52385a751eb384ae7e906c6f" }, --  NOTE: temporary
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      filetypes = { ["*"] = true },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      if pcall(require, "vim-dadbod-completion") then
        table.insert(opts.sources, {
          name = "vim-dadbod-completion",
        })
      end

      if pcall(require, "quarto") then
        table.insert(opts.sources, {
          name = "otter",
        })
      end
    end,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = function(_, opts)
      vim.keymap.set("n", "<A-Left>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<A-Down>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<A-Up>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<A-Right>", require("smart-splits").resize_right)
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "shellcheck", "shfmt" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        bashls = {},
        -- dbtls = {},
      },
      setup = {
        dbtls = function(_, opts)
          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")

          if not configs.dbtls then
            configs.dbtls = {
              default_config = {
                root_dir = lspconfig.util.root_pattern("dbt_project.yml"),
                cmd = { "dbt-language-server", "--stdio" },
                filetypes = { "sql", "dbt" },
                init_options = {
                  pythonInfo = { path = "python" },
                  lspMode = "dbtProject",
                  enableSnowflakeSyntaxCheck = true,
                  profilesDir = "./profiles.yml",
                },
              },
            }
          end

          lspconfig.dbtls.setup({ server = opts })
        end,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
      opts.filesystem.filtered_items.always_show = opts.filesystem.filtered_items.always_show or {}
      vim.list_extend(opts.filesystem.filtered_items.always_show, { ".buddy", ".deployment" })
    end,
  },
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
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
  { "echasnovski/mini.align", version = "*", opts = {} },
}
