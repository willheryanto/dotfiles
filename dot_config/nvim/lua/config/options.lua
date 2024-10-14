-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

local statusline_ascii = ""
opt.statusline = "%#Normal#" .. statusline_ascii .. "%="

-- opt.laststatus = 0
-- vim.cmd("hi! link StatusLine Normal")
-- vim.cmd("hi! link StatusLineNC Normal")
-- vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")
