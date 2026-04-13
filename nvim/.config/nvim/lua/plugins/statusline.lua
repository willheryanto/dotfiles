local project_terminal = require("config.project_terminal")

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = "",
      section_separators = "",
      disabled_filetypes = {
        statusline = { "snacks_dashboard" },
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        { "mode", fmt = function(s) return s:sub(1, 1) end },
        { "branch", icon = "" },
        {
          "diff",
          symbols = { added = " ", modified = " ", removed = " " },
        },
        { "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" } },
      },
      lualine_x = {
        {
          "diagnostics",
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
        {
          function()
            local status = vim.lsp.status()
            if status and status ~= "" then
              return "󰔟 " .. status:sub(1, 30)
            end
            return ""
          end,
          cond = function()
            return vim.lsp.status() ~= ""
          end,
        },
        {
          function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
              return ""
            end
            local names = {}
            for _, client in ipairs(clients) do
              table.insert(names, client.name)
            end
            return " " .. table.concat(names, ", ")
          end,
          cond = function()
            return #vim.lsp.get_clients({ bufnr = 0 }) > 0
          end,
        },
        {
          function()
            return ""
          end,
          cond = function()
            return project_terminal.status(0) == "hidden"
          end,
        },
        { "filetype", icon_only = true },
        { "location", padding = { left = 1, right = 1 } },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
