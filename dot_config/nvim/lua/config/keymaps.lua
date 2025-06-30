-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

if os.getenv("TMUX") then
  map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
  map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
  map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
  map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
end

vim.api.nvim_del_keymap("n", "<M-k>")
vim.api.nvim_del_keymap("n", "<M-j>")
vim.api.nvim_del_keymap("v", "<M-k>")
vim.api.nvim_del_keymap("v", "<M-j>")
vim.api.nvim_del_keymap("i", "<M-k>")
vim.api.nvim_del_keymap("i", "<M-j>")

vim.api.nvim_set_keymap('n', '<leader>cii', ':let @+ = fnamemodify(expand("%:p"), ":~:.")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cIi', ':let @+ = expand("%:p")<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>cIa', ':let @+ = "/add " . fnamemodify(expand("%:p"), ":~:.")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cia', ':let @+ = "/add " . expand("%:p")<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>cIr', ':let @+ = "/read-only " . fnamemodify(expand("%:p"), ":~:.")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cir', ':let @+ = "/read-only " . expand("%:p")<CR>', { noremap = true, silent = true })

-- New keymap for copying all opened buffers with a "/read-only" prefix
vim.api.nvim_set_keymap('n', '<leader>cb', ':lua CopyAllBuffersInReadOnly()<CR>', { noremap = true, silent = true })

function CopyAllBuffersInReadOnly()
  local bufs = vim.api.nvim_list_bufs()
  local paths = {}
  for _, buf in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then
        table.insert(paths, name)
      end
    end
  end
  local result = "/read-only " .. table.concat(paths, " ")
  vim.fn.setreg('+', result)
  print("Copied buffers to system clipboard")
end
