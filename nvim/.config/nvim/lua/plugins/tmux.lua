return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    -- Terminal mode: only navigate in non-floating terminals
    local function term_navigate(direction)
      return function()
        local win = vim.api.nvim_get_current_win()
        local win_config = vim.api.nvim_win_get_config(win)
        -- Skip floating windows (use tmux prefix instead)
        if win_config.relative ~= "" then
          return
        end
        vim.cmd("stopinsert")
        vim.cmd("TmuxNavigate" .. direction)
      end
    end

    vim.keymap.set("t", "<C-h>", term_navigate("Left"), { desc = "Navigate left" })
    vim.keymap.set("t", "<C-j>", term_navigate("Down"), { desc = "Navigate down" })
    vim.keymap.set("t", "<C-k>", term_navigate("Up"), { desc = "Navigate up" })
    vim.keymap.set("t", "<C-l>", term_navigate("Right"), { desc = "Navigate right" })
  end,
}
