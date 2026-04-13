local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- LSP keymaps on attach
autocmd("LspAttach", {
  group = augroup("lsp_keymaps", { clear = true }),
  callback = function(event)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
    end

    -- Use fzf-lua for LSP navigation (better UI, auto-jumps if single result)
    local fzf = require("fzf-lua")
    map("n", "gd", fzf.lsp_definitions, "Go to definition")
    map("n", "gD", fzf.lsp_declarations, "Go to declaration")
    map("n", "gR", fzf.lsp_references, "Show references") -- Changed to gR
    map("n", "gi", fzf.lsp_implementations, "Go to implementation")
    map("n", "gy", fzf.lsp_typedefs, "Go to type definition")
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map({ "n", "v" }, "<leader>ca", fzf.lsp_code_actions, "Code action")
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Resize splits on window resize
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "qf",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Wrap and spell check in text filetypes
autocmd("FileType", {
  group = augroup("wrap_spell", { clear = true }),
  pattern = { "gitcommit", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Markdown UI settings
autocmd("FileType", {
  group = augroup("markdown_ui", { clear = true }),
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

-- Auto create dir when saving a file
autocmd("BufWritePre", {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Auto-handle swap files: recover if newer, delete if older
autocmd("SwapExists", {
  group = augroup("auto_swap", { clear = true }),
  callback = function()
    local swapname = vim.v.swapname
    local filename = vim.fn.expand("<afile>:p")
    local swap_stat = vim.uv.fs_stat(swapname)
    local file_stat = vim.uv.fs_stat(filename)

    if swap_stat and file_stat and swap_stat.mtime.sec > file_stat.mtime.sec then
      -- Swap is newer, recover it
      vim.v.swapchoice = "r"
      vim.notify("Recovered from swap file", vim.log.levels.INFO)
    else
      -- Swap is older or file doesn't exist, delete swap
      vim.v.swapchoice = "d"
    end
  end,
})

-- Set .env files to bash filetype for syntax highlighting
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("env_filetype", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})
