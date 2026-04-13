-- Markdown language support: LSP + formatter + linter

-- Configure marksman (markdown LSP)
vim.lsp.config("marksman", {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  root_markers = { ".marksman.toml", ".git" },
})
vim.lsp.enable("marksman")

return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "markdown", "markdown_inline" },
    },
  },

  -- Formatter: markdownlint-cli2
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
      formatters = {
        ["markdownlint-cli2"] = {
          prepend_args = {
            "--config",
            vim.fn.expand("~/.config/nvim/markdownlint-cli2.jsonc"),
          },
        },
      },
    },
  },

  -- Linter: markdownlint
  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = {
  --     linters_by_ft = {
  --       markdown = { "markdownlint" },
  --     },
  --   },
  -- },

  -- Table mode: Easy markdown tables
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
    cmd = { "TableModeToggle", "TableModeEnable" },
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode" },
    },
  },

  -- Checkmate: Todo checkboxes for markdown
  {
    "bngarren/checkmate.nvim",
    ft = "markdown",
    opts = {
      files = {
        "~/notes/todos/*.md",
        "**/todo.md",
        "**/roadmap.md",
      },
    },
  },

  -- Render-markdown: Beautify markdown in Neovim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    ft = { "markdown", "norg", "org" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>um", function() require("render-markdown").toggle() end, desc = "Toggle Markdown Render" },
    },
    opts = {
      heading = {
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      checkbox = {
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
      },
      html = {
        comment = { conceal = false },
      },
    },
  },

  -- Live preview: Render Markdown/Mermaid in the browser with live updates
  {
    "brianhuster/live-preview.nvim",
    ft = { "markdown", "html", "svg", "asciidoc" },
    cmd = { "LivePreview" },
    keys = {
      { "<leader>mp", "<cmd>LivePreview start<cr>", desc = "Markdown Preview Start" },
      { "<leader>mc", "<cmd>LivePreview close<cr>", desc = "Markdown Preview Close" },
      { "<leader>mP", "<cmd>LivePreview pick<cr>", desc = "Markdown Preview Pick" },
    },
    config = function()
      require("livepreview.config").set({
        dynamic_root = true,
        picker = "snacks.picker",
        sync_scroll = true,
      })
    end,
  },
}
