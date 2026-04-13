local project_terminal = require("config.project_terminal")

return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.terminal = vim.tbl_deep_extend("force", opts.terminal or {}, {
        enabled = true,
      })
    end,
    init = function()
      vim.api.nvim_create_user_command("Terminal", function()
        project_terminal.toggle()
      end, { desc = "Toggle project terminal" })
    end,
    keys = {
      { "<leader>tt", project_terminal.toggle, desc = "Terminal (Project Root)" },
      { "<C-/>", project_terminal.toggle, desc = "Terminal (Project Root)" },
      { "<C-_>", project_terminal.toggle, desc = "which_key_ignore" },
      { "<C-/>", "<cmd>close<cr>", mode = "t", desc = "Hide Terminal" },
      { "<C-_>", "<cmd>close<cr>", mode = "t", desc = "which_key_ignore" },
    },
  },
}
