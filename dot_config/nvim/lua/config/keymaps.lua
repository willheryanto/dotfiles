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

vim.api.nvim_set_keymap('n', '<leader>ci', ':let @+ = fnamemodify(expand("%:p"), ":~:.")<CR>', { noremap = true, silent = true })
