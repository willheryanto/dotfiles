return {
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
        cucumber_language_server = {
          settings = {
            cucumber = {
              features = { "cypress/e2e/**/*.feature" },
              glue = { "cypress/e2e/**/*.js" },
            },
          },
        },
      },
    },
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
    enabled = true,
  },
  -- {
  --   "dmmulroy/ts-error-translator.nvim",
  --   opts = {},
  -- },
  {
    "dmmulroy/tsc.nvim",
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
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      -- "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
      lang = "cpp",
      keys = {
        reset_testcases = "R",
      },
    },
  },
  {
    "aaronik/treewalker.nvim",
    dependencies = {
      "folke/which-key.nvim",
    },
    keys = {
      {
        "<leader>m",
        group = "treewalker",
        desc = "+treewalker",
      },
      {
        "<leader>mk",
        "<cmd>Treewalker Up<cr>",
        desc = "Up",
      },
      {
        "<leader>mj",
        "<cmd>Treewalker Down<cr>",
        desc = "Down",
      },
      {
        "<leader>mh",
        "<cmd>Treewalker Left<cr>",
        desc = "Left",
      },
      {
        "<leader>ml",
        "<cmd>Treewalker Right<cr>",
        desc = "Right",
      },
      {
        "<leader>mK",
        "<cmd>Treewalker SwapUp<cr>",
        desc = "Up",
      },
      {
        "<leader>mJ",
        "<cmd>Treewalker SwapDown<cr>",
        desc = "Down",
      },
      {
        "<leader>mH",
        "<cmd>Treewalker SwapLeft<cr>",
        desc = "Left",
      },
      {
        "<leader>mL",
        "<cmd>Treewalker SwapRight<cr>",
        desc = "Right",
      },
      {
        "<leader>m<space>",
        function()
          require("which-key").show({ keys = "<leader>m", loop = true })
        end,
        desc = "Treewalker Hydra Mode (which-key)",
      },
    },

    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and setup() does not need to be called, so the whole opts block is optional as well.
    opts = {
      -- Whether to briefly highlight the node after jumping to it
      highlight = true,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = "CursorLine",
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = {
      sources = {
        default = { "avante" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {},
          },
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<c-f>"] = { "toggle_follow", mode = { "i", "n" } },
              ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
              ["<c-m>"] = { "toggle_maximize", mode = { "i", "n" } },
              ["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
            },
          },
        },
      },
    },
  },
  {
    "rgroli/other.nvim",
    opts = {
      mappings = {
        {
          -- Mapping from implementation file (e.g. index.ts) to unit test (index.test.ts)
          pattern = function(current)
            -- Do not match if the file already includes ".test."
            if current:find("%.test%.") then
              return nil
            end
            local cap1, cap2 = current:match("^(.-)%.([tj]sx?)$")
            if cap1 and cap2 then
              return { cap1, cap2 }
            end
            return nil
          end,
          target = "%1.test.%2",
          context = "test",
        },
        {
          -- Mapping from test file (unit or integration) back to the implementation file (e.g. index.test.ts or index.integ.test.ts -> index.ts)
          pattern = function(current)
            -- Matches both "basename.test.ext" and "basename.integ.test.ext"
            local base, ext = current:match("^(.*)%.test%.([tj]sx?)$")
            if base and ext then
              return { base, ext }
            end
            return nil
          end,
          target = "%1.%2",
          context = "implementation",
        },
      },
    },
    main = "other-nvim",
  },
  {
    "vim-test/vim-test",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = {
      "TestNearest",
      "TestFile",
      "TestSuite",
      "TestLast",
      "TestVisit",
    },
    -- keys = {
    --   { "<leader>tt", "<cmd>TestNearest<CR>", desc = "Run nearest test" },
    --   { "<leader>tf", "<cmd>TestFile<CR>", desc = "Run tests in file" },
    --   { "<leader>ts", "<cmd>TestSuite<CR>", desc = "Run entire test suite" },
    --   { "<leader>tl", "<cmd>TestLast<CR>", desc = "Run last test" },
    --   { "<leader>tv", "<cmd>TestVisit<CR>", desc = "Re-run last test" },
    -- },
    config = function()
      -- Use Neovim terminal for running tests
      vim.g["test#strategy"] = "neovim"
    end,
  },
  {
    "PedramNavid/dbtpal",
    opts = {},
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      {
        -- Open in the current working directory
        "<leader>fe",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>fE",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      { "<leader>e", "<leader>fe", desc = "Yazi (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Yazi (cwd)", remap = true },
    },
    opts = {},
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        opts = {
          windows = {
            terminal = {
              hide = { "pwa-node", "node" },
            },
          },
        },
        config = function(_, opts)
          local dap, dv = require("dap"), require("dap-view")
          dap.listeners.before.attach["dap-view-config"] = function()
            dv.open()
          end
          dap.listeners.before.launch["dap-view-config"] = function()
            dv.open()
          end
          dap.listeners.before.event_terminated["dap-view-config"] = function()
            dv.close()
          end
          dap.listeners.before.event_exited["dap-view-config"] = function()
            dv.close()
          end

          dv.setup(opts)
        end,
      },
    },
    opts = {},
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
  },
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = function()
      require("copilot.api").status = require("copilot.status")
    end,
  },
  {
    "stevearc/overseer.nvim",
    config = function(_, opts)
      local overseer = require("overseer")

      overseer.register_template({
        name = "aider commit",
        builder = function()
          return {
            cmd = { "aider", "--commit" },
          }
        end,
        priority = 10,
      })

      overseer.setup(opts)
    end,
  },
}
