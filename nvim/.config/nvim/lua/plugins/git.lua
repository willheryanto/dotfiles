return {
  -- Fugitive: Git commands
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gread", "Gwrite", "Gdiffsplit", "Gvdiffsplit" },
    keys = {
      { "<leader>gB", "<cmd>Git blame<cr>", desc = "Git Blame (fugitive)" },
    },
  },

  -- Gitsigns: Git hunks in sign column
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = require("gitsigns")
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- Navigation
        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")

        -- Actions
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
      end,
    },
  },

  -- Codediff: Side-by-side diffs
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },

  -- Snacks: For lazygit floating terminal
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 900,
    opts = {
      lazygit = { enabled = true },
      terminal = { enabled = true },
      zen = { enabled = true },
    },
    keys = {
      { "<leader>gg", function() require("snacks").lazygit() end, desc = "Lazygit (cwd)" },
      { "<leader>gG", function() require("snacks").lazygit({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Lazygit (file dir)" },
      { "<leader>gf", function() require("snacks").lazygit.log_file() end, desc = "Lazygit File History" },
      { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit Log" },
      { "<leader>gy", function() require("snacks").gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false }) end, desc = "Copy Git URL", mode = { "n", "x" } },
      { "<leader>gY", function() require("snacks").gitbrowse() end, desc = "Open Git URL", mode = { "n", "x" } },
    },
  },

  -- FzfLua: Git pickers
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Status" },
      { "<leader>gS", "<cmd>FzfLua git_stash<cr>", desc = "Stash" },
      { "<leader>gm", function()
        local fzf = require("fzf-lua")
        fzf.fzf_exec("git status --short --untracked-files=no | awk '{ key = (substr($0,2,1) != \" \") ? 0 : 1; print key \"\\t\" $0 }' | sort -k1,1 -s", {
          prompt = "Git> ",
          preview = "sh -c 'status=\"$1\"; file=\"$2\"; s1=\"${status%?}\"; s2=\"${status#?}\"; if [ \"$s1\" != \" \" ] && [ \"$s2\" != \" \" ]; then git diff --color=always --cached -- \"$file\"; printf \"\\n\"; git diff --color=always -- \"$file\"; elif [ \"$s1\" != \" \" ]; then git diff --color=always --cached -- \"$file\"; else git diff --color=always -- \"$file\"; fi' -- {2} {4}",
          fn_transform = function(x)
            local fields = vim.split(x, "\t")
            local key = fields[1] or ""
            local raw = fields[2] or ""
            local status = raw:sub(1, 2)
            local file = raw:sub(4)
            local status_map = {
              M = "Modified",
              A = "Added",
              D = "Deleted",
              R = "Renamed",
              C = "Copied",
              U = "Unmerged",
            }
            local status_colors = {
              M = "\27[33m",
              A = "\27[32m",
              D = "\27[31m",
              R = "\27[35m",
              C = "\27[36m",
              U = "\27[31m",
            }
            local reset = "\27[0m"

            local renamed = file:match("->%s*(.+)$")
            if renamed then
              file = renamed
            end

            local staged = status:sub(1, 1)
            local unstaged = status:sub(2, 2)
            local parts = {}
            if staged ~= " " then
              local label = status_map[staged] or staged
              local color = status_colors[staged] or ""
              table.insert(parts, "\27[32mS\27[0m: " .. color .. label .. reset)
            end
            if unstaged ~= " " then
              local label = status_map[unstaged] or unstaged
              local color = status_colors[unstaged] or ""
              table.insert(parts, "\27[31mU\27[0m: " .. color .. label .. reset)
            end
            if #parts == 0 then
              return x
            end
            return key .. "\t" .. status .. "\t" .. table.concat(parts, ", ") .. "\t" .. file
          end,
          actions = {
            ["default"] = function(selected)
              local fields = vim.split(selected[1], "\t")
              local file = fields[4]
              if file then vim.cmd("edit " .. file) end
            end,
          },
          fzf_opts = { ["--ansi"] = "", ["--delimiter"] = "\t", ["--with-nth"] = "3,4" },
        })
      end, desc = "Git status files" },
      { "<leader>gu", function()
        require("fzf-lua").fzf_exec("git ls-files --others --exclude-standard", {
          prompt = "Untracked> ",
          preview = "bat --style=numbers --color=always {}",
          actions = {
            ["default"] = require("fzf-lua.actions").file_edit,
          },
        })
      end, desc = "Untracked files" },
    },
  },
}
