return {
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
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.bashls = opts.servers.bashls or {}
      opts.servers.bashls = {}
    end,
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
}
