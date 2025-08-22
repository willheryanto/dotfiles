return {
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
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
  {
    "jake-stewart/force-cul.nvim",
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
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
      ---@class snacks.terminal.Config
      terminal = {
        start_insert = true,
        auto_insert = false,
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
    "christoomey/vim-tmux-navigator",
  },
}
