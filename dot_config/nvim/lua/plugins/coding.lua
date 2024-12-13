return {
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
  {
    "nvchad/volt",
    keys = {
      { "<leader>cp", "", desc = "+Color Picker" },
      {
        "<leader>cph",
        function()
          require("minty.huefy").open()
        end,
        desc = "Huefy",
      },
    },
    lazy = true,
  },
  {
    "nvchad/minty",
    keys = {
      { "<leader>cp", "", desc = "+Color Picker" },
      {
        "<leader>cps",
        function()
          require("minty.shades").open()
        end,
        desc = "Shades",
      },
    },

    lazy = true,
  },
  { "brenoprata10/nvim-highlight-colors", opts = {} },
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    opts = {},
  },
  {
    "jake-stewart/force-cul.nvim",
    opts = {},
  },
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
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
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

      opts.servers.vtsls = vim.tbl_extend("force", opts.servers.vtsls or {}, {
        settings = {
          typescript = {
            preferences = {
              importModuleSpecifier = "relative",
            },
          },
        },
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")
      opts.files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-."] = { actions.toggle_hidden },
        },
      }
      opts.grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-."] = { actions.toggle_hidden },
        },
      }

      return opts
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      html = {
        comment = {
          conceal = false,
        },
      },
    },
  }
}
