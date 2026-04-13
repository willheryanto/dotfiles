local uv = vim.uv or vim.loop

local M = {}

local function realpath(path)
  if not path or path == "" then
    return nil
  end
  return uv.fs_realpath(path) or path
end

local function bufpath(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return nil
  end
  return realpath(name)
end

local function lsp_root(buf)
  local path = bufpath(buf)
  if not path then
    return nil
  end

  local roots = {}
  local function add(root)
    root = realpath(root)
    local matches = root and (path == root or path:find(root .. "/", 1, true) == 1)
    if matches and not vim.tbl_contains(roots, root) then
      roots[#roots + 1] = root
    end
  end

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
    for _, workspace in ipairs(client.config.workspace_folders or client.workspace_folders or {}) do
      add(vim.uri_to_fname(workspace.uri))
    end
    add(client.config.root_dir or client.root_dir)
  end

  table.sort(roots, function(a, b)
    return #a > #b
  end)

  return roots[1]
end

local function git_root(buf)
  local path = bufpath(buf)
  local search = path and vim.fn.fnamemodify(path, ":h") or uv.cwd()
  local git_dir = vim.fs.find(".git", { path = search, upward = true })[1]
  return git_dir and vim.fn.fnamemodify(git_dir, ":h") or nil
end

function M.project_root(buf)
  return lsp_root(buf) or git_root(buf) or realpath(uv.cwd()) or uv.cwd()
end

function M.terminal_opts(buf)
  return {
    cwd = M.project_root(buf or 0),
    count = 1,
    win = {
      position = "bottom",
      height = 0.35,
    },
  }
end

function M.toggle()
  require("snacks").terminal.focus(nil, M.terminal_opts(0))
end

function M.status(buf)
  local ok, snacks = pcall(require, "snacks")
  if not ok or not snacks.terminal or not snacks.terminal.get then
    return "never_opened"
  end

  local terminal = snacks.terminal.get(nil, vim.tbl_extend("force", M.terminal_opts(buf or 0), { create = false }))
  if not terminal or not terminal:buf_valid() then
    return "never_opened"
  end

  if terminal:win_valid() and terminal:on_current_tab() then
    return "visible"
  end

  return "hidden"
end

return M

