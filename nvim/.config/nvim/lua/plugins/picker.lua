local function workspace_symbols()
  local method = vim.lsp.protocol.Methods.workspace_symbol

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client:supports_method(method) then
      require("fzf-lua").lsp_live_workspace_symbols()
      return
    end
  end

  vim.notify("No attached LSP client supports workspace symbols for this buffer", vim.log.levels.WARN)
end

return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    -- Top-level shortcuts (LazyVim style)
    { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Switch Buffer" },
    { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Root Dir)" },
    { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files (Root Dir)" },
    { "<leader>xx", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
    { "<leader>xX", "<cmd>FzfLua diagnostics_document<cr>", desc = "Buffer Diagnostics" },
    { "<leader>xs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Symbols" },
    { "<leader>xL", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
    { "<leader>xQ", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
    -- Find
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    { "<leader>fc", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files (Root Dir)" },
    { "<leader>fF", function() require("fzf-lua").files({ cwd = vim.uv.cwd() }) end, desc = "Find Files (cwd)" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
    { "<leader>fR", function() require("fzf-lua").oldfiles({ cwd = vim.uv.cwd() }) end, desc = "Recent (cwd)" },
    -- Search
    { "<leader>s\"", "<cmd>FzfLua registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Buffer Lines" },
    { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
    { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Root Dir)" },
    { "<leader>sG", function() require("fzf-lua").live_grep({ cwd = vim.uv.cwd() }) end, desc = "Grep (cwd)" },
    { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Highlight Groups" },
    { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
    { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
    { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
    { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
    { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Word (Root Dir)" },
    { "<leader>sW", function() require("fzf-lua").grep_cword({ cwd = vim.uv.cwd() }) end, desc = "Word (cwd)" },
    { "<leader>sw", "<cmd>FzfLua grep_visual<cr>", mode = "v", desc = "Selection (Root Dir)" },
    { "<leader>sW", function() require("fzf-lua").grep_visual({ cwd = vim.uv.cwd() }) end, mode = "v", desc = "Selection (cwd)" },
    -- LSP
    { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Goto Symbol" },
    { "<leader>sS", workspace_symbols, desc = "Goto Symbol (Workspace)" },
    -- UI
    { "<leader>uC", "<cmd>FzfLua colorschemes<cr>", desc = "Colorscheme with Preview" },
  },
  opts = {
    defaults = {
      git_icons = true,
      file_icons = true,
    },
    winopts = {
      height = 0.85,
      width = 0.80,
      preview = {
        layout = "vertical",
        vertical = "down:45%",
      },
    },
    files = {
      cwd_prompt = false,
    },
    grep = {
      rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
    },
    fzf_opts = {
      ["--cycle"] = true,
    },
    lsp = {
      -- Jump directly if only one result
      jump1 = true,
    },
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept",
        ["ctrl-u"] = "half-page-up",
        ["ctrl-d"] = "half-page-down",
        ["ctrl-f"] = "preview-page-down",
        ["ctrl-b"] = "preview-page-up",
        ["shift-down"] = "preview-down",
        ["shift-up"] = "preview-up",
      },
    },
  },
}
