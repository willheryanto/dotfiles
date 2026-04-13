local vault_root = vim.fs.normalize(vim.fn.expand("~/vaults/main"))

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  cond = function()
    return vim.uv.fs_stat(vault_root) ~= nil
  end,
  ft = "markdown",
  cmd = "Obsidian",
  keys = {
    { "<leader>oc", "<cmd>Obsidian toc<cr>", desc = "Current note outline" },
    { "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Daily notes" },
    { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch note" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Current note links" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
    { "<leader>oo", "<cmd>Obsidian today<cr>", desc = "Today's note" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Tags" },
  },
  ---@module "obsidian"
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "main",
        path = "~/vaults/main",
      },
    },
    templates = {
      folder = "Templates",
      date_format = "YYYY-MM-DD",
      time_format = "HH:mm",
      substitutions = {},
    },
    sync = {
      enabled = true,
      mode = "bidirectional",
      conflict_strategy = "merge",
      file_types = {},
      device_name = "nvim-main",
    },
    picker = {
      name = "fzf-lua",
    },
  },
}
