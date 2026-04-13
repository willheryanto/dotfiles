local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "nosplit" -- Preview substitutions

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.showmode = false

-- Split behavior
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- File handling
opt.autowrite = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.confirm = true

-- Clipboard
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10

-- Misc
opt.mouse = "a"
opt.timeoutlen = 300
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"

-- Fold (using indent by default)
opt.foldlevel = 99
opt.foldmethod = "indent"

-- Fill chars
opt.fillchars = {
  fold = " ",
  diff = "╱",
  eob = " ",
}

-- Grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Disable some builtin providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Diagnostics
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})
