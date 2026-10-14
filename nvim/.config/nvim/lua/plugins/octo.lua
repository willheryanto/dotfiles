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
    mappings = {
      submit_win = {
        approve_review = { lhs = "<C-p>", desc = "Approve review" },
      },
    },
  },
  config = function(_, opts)
    require("octo").setup(opts)

    local function when_octo_pr_ready(bufnr, callback)
      local attempts = 0

      local function retry()
        if not vim.api.nvim_buf_is_valid(bufnr) or vim.api.nvim_get_current_buf() ~= bufnr then
          return
        end

        local buffer = require("octo.utils").get_current_buffer()
        if buffer and buffer:isPullRequest() then
          callback()
          return
        end

        attempts = attempts + 1
        if attempts < 50 then
          vim.defer_fn(retry, 100)
        else
          vim.notify("Octo PR is still loading", vim.log.levels.WARN)
        end
      end

      retry()
    end

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

        local uri = require("octo.uri").parse(vim.api.nvim_buf_get_name(args.buf))
        if uri and uri.kind == "pull" then
          vim.keymap.set("n", "<localleader>vs", function()
            when_octo_pr_ready(args.buf, function()
              require("octo.reviews").start_review()
            end)
          end, {
            buffer = args.buf,
            silent = true,
            desc = "Start PR review",
          })

          local ok, which_key = pcall(require, "which-key")
          if ok and not vim.b[args.buf].octo_which_key_registered then
            which_key.add({
              { "<localleader>vs", desc = "Start PR review", buffer = args.buf },
            })
            vim.b[args.buf].octo_which_key_registered = true
          end

          vim.keymap.set("n", "]s", function()
            when_octo_pr_ready(args.buf, function()
              require("octo.navigation").go_to_stack_neighbor(1)
            end)
          end, {
            buffer = args.buf,
            silent = true,
            desc = "Open next PR up the stack",
          })
        end
      end,
    })
  end,
}
