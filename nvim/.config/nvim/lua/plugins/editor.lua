return {
  -- Leap: Fast 2-character motions
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    name = "leap.nvim",
    config = function()
      local leap = require("leap")

      -- Keep label preview enabled and make labels consistently visible across themes.
      leap.opts.preview = true

      local function set_leap_highlights()
        leap.init_hl(true)

        vim.api.nvim_set_hl(0, "LeapLabel", {
          fg = "#1D1C19",
          bg = "#E6C384",
          bold = true,
        })
        vim.api.nvim_set_hl(0, "LeapMatch", {
          fg = "#C4B28A",
          bold = true,
          underline = true,
        })

        -- Dim non-target text while leap is active.
        require("leap.user").set_backdrop_highlight("Comment")
        -- Recompute derived concealed-label highlight after overriding LeapLabel.
        leap.init_hl()
      end

      set_leap_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("LeapIndicatorHighlights", { clear = true }),
        callback = set_leap_highlights,
      })
    end,
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("leap").leap({
            windows = { vim.api.nvim_get_current_win() },
            inclusive = true,
          })
        end,
        desc = "Leap",
      },
      {
        "S",
        mode = "n",
        function()
          require("leap").leap({
            windows = require("leap.user").get_enterable_windows(),
          })
        end,
        desc = "Leap From Window",
      },
      {
        "r",
        mode = "o",
        function()
          require("leap.remote").action()
        end,
        desc = "Remote Leap",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("leap.treesitter").select()
        end,
        desc = "Leap Treesitter",
      },
    },
  },

  -- Aerial: Code outline / symbols tree
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialInfo", "AerialNavToggle" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- Refresh symbols while editing in insert mode (e.g. markdown headings).
      update_events = "TextChanged,TextChangedI,InsertLeave",
    },
    keys = {
      { "<leader>cs", "<cmd>AerialToggle!<cr>", desc = "Symbols (Aerial)" },
    },
  },

  -- Todo Comments: Highlight and search TODOs
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoQuickFix", "TodoFzfLua" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>TodoQuickFix<cr>", desc = "Todo (Quickfix)" },
      { "<leader>xT", "<cmd>TodoQuickFix keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Quickfix)" },
      { "<leader>st", "<cmd>TodoFzfLua<cr>", desc = "Todo" },
    },
  },
}
