-- Leader keys (must be set before any mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Let Oil handle directory buffers instead of netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load config
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
