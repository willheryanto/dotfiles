-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "json",
    "quarto",
  },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})

vim.cmd([[
augroup WrapLineInTeXFile
    autocmd FileType tex setlocal wrap
augroup END
]])

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.wrap = false
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.rsx",
  callback = function()
    vim.bo.filetype = "tsx"
  end,
})
