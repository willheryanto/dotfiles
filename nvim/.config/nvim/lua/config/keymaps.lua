local map = vim.keymap.set

local function jump_relative_file(step)
  local current_path = vim.api.nvim_buf_get_name(0)
  if current_path == "" then
    vim.notify("Current buffer is not a file", vim.log.levels.WARN)
    return
  end

  local absolute_path = vim.fn.fnamemodify(current_path, ":p")
  local dir = vim.fn.fnamemodify(absolute_path, ":h")
  local current_name = vim.fn.fnamemodify(absolute_path, ":t")

  local scan = vim.uv.fs_scandir(dir)
  if not scan then
    vim.notify("Unable to scan directory: " .. dir, vim.log.levels.WARN)
    return
  end

  local files = {}
  while true do
    local name, file_type = vim.uv.fs_scandir_next(scan)
    if not name then
      break
    end
    if file_type == "file" then
      files[#files + 1] = name
    end
  end

  if #files == 0 then
    vim.notify("No files found in: " .. dir, vim.log.levels.WARN)
    return
  end

  table.sort(files)

  local current_idx
  for i, name in ipairs(files) do
    if name == current_name then
      current_idx = i
      break
    end
  end

  if not current_idx then
    vim.notify("Current file is not part of directory listing", vim.log.levels.WARN)
    return
  end

  local target_idx = ((current_idx - 1 + step) % #files) + 1
  local target_path = dir .. "/" .. files[target_idx]
  vim.cmd.edit(vim.fn.fnameescape(target_path))
end

-- Better up/down (respects wrapped lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[f", function() jump_relative_file(-1) end, { desc = "Prev file (same dir)" })
map("n", "]f", function() jump_relative_file(1) end, { desc = "Next file (same dir)" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Delete other buffers" })

-- Clear search highlight
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "<leader>ur", "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch" })

-- Better search navigation
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Disable Ex mode
map("n", "Q", "<Nop>", { desc = "Disable Ex mode" })
map("n", "gQ", "<Nop>", { desc = "Disable Ex mode" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Commenting (requires Neovim 0.10+)
-- map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
-- map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })

-- File/buffer commands
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

-- Quickfix/location list
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location list" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix list" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })

-- Diagnostic navigation
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
map("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next error" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Prev error" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Windows
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>wm", function() require("snacks").zen.zoom() end, { desc = "Maximize window" })

-- Tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

-- Toggle options
map("n", "<leader>us", "<cmd>set spell!<cr>", { desc = "Toggle spelling" })
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })
map("n", "<leader>ul", "<cmd>set number!<cr>", { desc = "Toggle line numbers" })
map("n", "<leader>uL", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative numbers" })

-- Inspect
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect pos" })

-- Copy file path
map("n", "<leader>cp", ':let @+ = fnamemodify(expand("%:p"), ":~:.")<CR>', { silent = true, desc = "Copy relative path" })
map("n", "<leader>cP", ':let @+ = expand("%:p")<CR>', { silent = true, desc = "Copy absolute path" })
