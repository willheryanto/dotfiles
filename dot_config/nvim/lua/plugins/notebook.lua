return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      -- vim.g.molten_show_mimetype_debug = true
      vim.g.molten_auto_open_output = true
      -- vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_crop_border = true
      -- vim.g.molten_output_show_more = true
      vim.g.molten_output_win_border = { "", "━", "", "" }
      vim.g.molten_output_win_max_height = 12
      -- vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_text_output = false
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true

      vim.keymap.set("n", "<leader>ni", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
      vim.keymap.set("n", "<leader>np", function()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv ~= nil then
          -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
          venv = string.match(venv, "/.+/(.+)")
          vim.cmd(("MoltenInit %s"):format(venv))
        else
          vim.cmd("MoltenInit python3")
        end
      end, { desc = "Initialize Molten for python3", silent = true, noremap = true })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInitPost",
        callback = function()
          -- quarto code runner mappings
          local r = require("quarto.runner")
          vim.keymap.set("n", "<leader>rr", r.run_cell, { desc = "run cell", silent = true })
          vim.keymap.set("n", "<leader>ra", r.run_above, { desc = "run cell and above", silent = true })
          vim.keymap.set("n", "<leader>rb", r.run_below, { desc = "run cell and below", silent = true })
          vim.keymap.set("n", "<leader>rl", r.run_line, { desc = "run line", silent = true })
          vim.keymap.set("n", "<leader>rA", r.run_all, { desc = "run all cells", silent = true })
          vim.keymap.set("n", "<leader>RA", function()
            r.run_all(true)
          end, { desc = "run all cells of all languages", silent = true })

          -- setup some molten specific keybindings
          vim.keymap.set(
            "n",
            "<leader>ne",
            ":MoltenEvaluateOperator<CR>",
            { desc = "evaluate operator", silent = true }
          )
          vim.keymap.set("n", "<leader>nr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
          vim.keymap.set(
            "v",
            "<leader>nr",
            ":<C-u>MoltenEvaluateVisual<CR>gv",
            { desc = "execute visual selection", silent = true }
          )
          vim.keymap.set(
            "n",
            "<leader>os",
            ":noautocmd MoltenEnterOutput<CR>",
            { desc = "open output window", silent = true }
          )
          vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
          -- local open = false
          -- vim.keymap.set("n", "<leader>ot", function()
          --   open = not open
          --   vim.fn.MoltenUpdateOption("auto_open_output", open)
          -- end)
        end,
      })
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
    },
    ft = { "quarto", "markdown" },
    config = function()
      local quarto = require("quarto")
      quarto.setup({
        lspFeatures = {
          languages = { "python" },
          chunks = "all", -- 'curly' or 'all'
          diagnostics = {
            enabled = true,
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "K",
          definition = "gd",
          rename = "<leader>cr",
          references = "gr",
          format = "<leader>cf",
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        },
      })

      vim.keymap.set("n", "<leader>nc", "i```{}\r```<up><right>", { desc = "Create a new code cell", silent = true })
      vim.keymap.set(
        "n",
        "<leader>ns",
        "i```\r\r```{}<left>",
        { desc = "Split code cell", silent = true, noremap = true }
      )
    end,
  },
}
