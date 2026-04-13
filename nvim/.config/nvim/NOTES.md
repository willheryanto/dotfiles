# Neovim Configuration

A minimal, modern Neovim configuration using native LSP and lazy.nvim.

## Structure

```
~/.config/nvim-new/
├── init.lua                      # Entry point - leader keys + require config
├── .luarc.json                   # Lua LSP settings for this project
├── lua/
│   ├── config/
│   │   ├── options.lua           # Vim options + diagnostics
│   │   ├── keymaps.lua           # Global keymaps
│   │   ├── autocmds.lua          # Autocommands + LSP keymaps on attach
│   │   └── lazy.lua              # lazy.nvim bootstrap
│   └── plugins/
│       ├── treesitter.lua        # Syntax highlighting
│       ├── completion.lua        # blink.cmp
│       ├── picker.lua            # fzf-lua
│       ├── formatting.lua        # conform.nvim
│       ├── linting.lua           # nvim-lint
│       ├── git.lua               # fugitive, gitsigns, lazygit
│       ├── which-key.lua         # Keymap discovery
│       ├── colorscheme.lua       # kanagawa dragon
│       ├── statusline.lua        # lualine (minimal)
│       └── lang/
│           ├── lua.lua           # Lua: LSP + formatter
│           ├── markdown.lua      # Markdown: LSP + formatter + linter
│           └── typescript.lua    # TS/JS: LSP + formatter + linter
```

## Plugins

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| nvim-treesitter | Syntax highlighting |
| blink.cmp | Completion |
| fzf-lua | Fuzzy finder |
| conform.nvim | Formatting |
| nvim-lint | Linting |
| gitsigns.nvim | Git hunks |
| vim-fugitive | Git commands |
| snacks.nvim | Lazygit terminal |
| which-key.nvim | Keymap hints |
| kanagawa.nvim | Colorscheme |
| lualine.nvim | Statusline |

## Key Features

### Native LSP (Neovim 0.11+)
- Uses `vim.lsp.config()` and `vim.lsp.enable()` instead of nvim-lspconfig
- LSP settings via `.luarc.json` per project
- Keymaps set on `LspAttach` event

### LSP Keymaps
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Implementation |
| `gy` | Type definition |
| `K` | Hover docs |
| `gK` | Signature help |
| `<leader>cr` | Rename |
| `<leader>ca` | Code action |

### Picker (fzf-lua)
| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>,` | Switch buffer |
| `<leader>/` | Live grep |
| `<leader>:` | Command history |
| `<leader>ff` | Find files |
| `<leader>fg` | Git files |
| `<leader>fr` | Recent files |
| `<leader>sg` | Grep |
| `<leader>sw` | Grep word |
| `<leader>ss` | LSP symbols |
| `<leader>sk` | Keymaps |
| `<leader>sh` | Help |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit |
| `<leader>gf` | File history |
| `<leader>gl` | Git log |
| `<leader>gs` | Git status (fzf) |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghp` | Preview hunk |
| `]h` / `[h` | Next/prev hunk |

### Formatting
| Key | Action |
|-----|--------|
| `<leader>cf` | Format file |

### Flash (Navigation)
| Key | Action |
|-----|--------|
| `s` | Flash jump |
| `S` | Flash treesitter |
| `r` | Remote flash (operator) |
| `R` | Treesitter search |
| `<C-s>` | Toggle flash search (cmdline) |

### Trouble (Diagnostics)
| Key | Action |
|-----|--------|
| `<leader>xx` | Diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>cs` | Symbols |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |
| `<leader>xt` | Todo list |
| `]q` / `[q` | Next/prev quickfix item |
| `]t` / `[t` | Next/prev todo comment |

### Noice
| Key | Action |
|-----|--------|
| `<leader>snl` | Last message |
| `<leader>snh` | Message history |
| `<leader>sna` | All messages |
| `<leader>snd` | Dismiss all |
| `<C-f>` / `<C-b>` | Scroll in docs |

### Other
| Key | Action |
|-----|--------|
| `<leader>?` | Buffer keymaps |
| `<leader>uC` | Colorscheme picker |
| `<leader>st` | Search todos |

## Adding a New Language

Create `lua/plugins/lang/<language>.lua`:

```lua
-- Example: lua/plugins/lang/typescript.lua

-- Configure LSP
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  root_markers = { "tsconfig.json", "package.json", ".git" },
})
vim.lsp.enable("ts_ls")

return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
    },
  },

  -- Linter (optional)
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        typescript = { "eslint" },
      },
    },
  },
}
```

Add treesitter parsers to `lua/plugins/treesitter.lua`.

## Requirements

```bash
# Core
brew install neovim fzf ripgrep

# Lua
brew install lua-language-server stylua

# Markdown
brew install marksman markdownlint-cli

# TypeScript/JavaScript
npm install -g @vtsls/language-server prettier eslint

# Python
pip install basedpyright ruff

# Go
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest

# JSON/YAML/TOML
npm install -g vscode-langservers-extracted yaml-language-server
brew install taplo

# Git
brew install lazygit

# Cucumber/Gherkin (Cypress)
npm install -g @cucumber/language-server

# DAP (TypeScript/JavaScript debugging)
# Clone and build vscode-js-debug (path: ~/ghq/github.com/microsoft/vscode-js-debug)
cd ~/ghq/github.com/microsoft
git clone https://github.com/microsoft/vscode-js-debug
cd vscode-js-debug
npm install
npx gulp dapDebugServer
```

## Running

```bash
# Use new config
NVIM_APPNAME=nvim-new nvim

# Alias (add to shell config)
alias nvim-new='NVIM_APPNAME=nvim-new nvim'
```

---

## Future Additions

### Languages
- [x] TypeScript/JavaScript (`vtsls`, prettier, eslint)
- [ ] Rust (`rust-analyzer`, rustfmt)
- [x] Go (`gopls`, goimports)
- [x] Python (`basedpyright`, ruff)
- [x] JSON/YAML/TOML (jsonls, yamlls, taplo + SchemaStore)
- [x] Markdown (`marksman`, markdownlint-cli2)

### Plugins
- [x] mini.surround - Surround text objects
- [x] mini.ai - Better text objects
- [x] flash.nvim - Fast navigation
- [x] trouble.nvim - Better diagnostics list
- [x] todo-comments.nvim - Highlight TODOs
- [x] oil.nvim - File explorer (edit filesystem like a buffer)
- [x] noice.nvim - Better UI for messages/cmdline
- [x] indent-blankline.nvim - Indent guides
- [ ] copilot.lua or codeium - AI completion

### Features
- [ ] Session management
- [ ] Project management
- [x] Debug adapter (DAP) - TypeScript/JavaScript
- [ ] Test runner integration
- [ ] Snippets (custom)
- [ ] Markdown preview
- [ ] Terminal integration improvements
