-- Octo: GitHub issues and PRs in Neovim
return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "ibhagwan/fzf-lua",
  },
  keys = {
    { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List Issues" },
    { "<leader>gI", "<cmd>Octo issue create<cr>", desc = "Create Issue" },
    { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List PRs" },
    { "<leader>gP", "<cmd>Octo pr create<cr>", desc = "Create PR" },
    { "<leader>gr", "<cmd>Octo repo list<cr>", desc = "List Repos" },
    { "<leader>gA", "<cmd>Octo actions<cr>", desc = "Octo Actions" },
  },
  opts = {
    picker = "fzf-lua",
    suppress_missing_scope = {
      projects_v2 = true,
    },
  },
  config = function(_, opts)
    require("octo").setup(opts)

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "octo://*",
      callback = function(args)
        vim.keymap.set("n", "<leader>cO", function()
          local uri = vim.api.nvim_buf_get_name(args.buf)
          local relpath = uri:match("/file/[^/]+/(.+)$")
          local value = relpath or uri
          vim.fn.setreg("+", value)
        end, {
          buffer = args.buf,
          silent = true,
          desc = "Copy Octo file path",
        })
      end,
    })
  end,
}
