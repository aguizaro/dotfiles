# dotfiles

Personal dotfiles for zsh, tmux, iterm2, vim, and neovim.

## Contents

- `zsh/zshrc` — full personal zsh config
- `zsh/ec_zshrc` — shared EC team zsh config (aliases, tmux pane titles)
- `tmux/tmux.conf` — tmux config
- `vim/vimrc` — vim config
- `nvim/` — neovim config (lazy.nvim, LSP, treesitter, telescope, etc.)
- `iterm2/` — iTerm2 preferences

## Structure

```
dotfiles/
├── install.sh
├── zsh/
│   ├── zshrc
│   └── ec_zshrc
├── tmux/
│   └── tmux.conf
├── vim/
│   └── vimrc
├── nvim/
│   ├── init.lua
│   └── lua/
└── iterm2/
    ├── com.googlecode.iterm2.plist
    └── com.googlecode.iterm2.private.plist
```

## Install

> **Note:** These dotfiles are designed for macOS.

### Prerequisites

Install dependencies via Homebrew before running the install script. If you don't have Homebrew, install it first at [brew.sh](https://brew.sh).

```bash
brew install tmux
brew install --cask iterm2
```

### Setup

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh [options]
```

### Options

| Flag | Description |
|---|---|
| `--zsh` | Install zsh config |
| `--tmux` | Install tmux config |
| `--vim` | Install vim config |
| `--nvim` | Install neovim config (symlinks `nvim/` → `~/.config/nvim`) |
| `--all` | Install everything |
| `--ec` | Use the shared EC zsh config instead of the full personal one |
| `--append` | Append a `source` line to your existing `~/.zshrc` instead of symlinking over it (zsh only) |

## Personal machine

```bash
./install.sh --all
```

Symlinks `zshrc` → `~/.zshrc`, `tmux.conf` → `~/.tmux.conf`, `vimrc` → `~/.vimrc`, `nvim/` → `~/.config/nvim`. Backs up any existing files before overwriting.

## Teammate / EC install

```bash
./install.sh --zsh --ec --append --tmux
```

- Symlinks `ec_zshrc` → `~/.ec_zshrc`
- Appends `source ~/.ec_zshrc  # EC dotfiles` to your existing `~/.zshrc` (non-destructive, idempotent)
- Symlinks `tmux.conf` → `~/.tmux.conf`

Your existing `~/.zshrc` and oh-my-zsh setup are left intact.

## Neovim

`./install.sh --nvim` (or `--all`) symlinks the whole `nvim/` directory to `~/.config/nvim`. On first launch, [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself and installs every plugin pinned in `lazy-lock.json`.

### Prerequisites

```bash
brew install neovim ripgrep   # ripgrep powers Telescope live-grep
brew install node             # required by Copilot and several LSP servers
```

- A C compiler (Xcode Command Line Tools) is needed for Treesitter parser builds.
- Formatters are installed on demand via [Mason](https://github.com/williamboman/mason.nvim) (`:Mason`); some (`stylua`, `black`, `isort`, `prettier`) can also come from Homebrew.
- Install a NerdFont (see the iTerm2 section) so icons in the dashboard, statusline, and file tree render correctly.

### Layout

```
nvim/
├── init.lua              # bootstraps lazy.nvim, loads vim-options + plugins
├── lazy-lock.json        # pinned plugin versions (commit this for reproducibility)
├── .luarc.json           # lua_ls settings (declares vim/filesystem globals)
└── lua/
    ├── vim-options.lua   # core editor settings (tabs, undofile, leader key, …)
    └── plugins/          # one file per plugin, auto-loaded by lazy.nvim
```

`init.lua` calls `require("lazy").setup("plugins")`, which imports every file under `lua/plugins/`, so adding a plugin is just dropping a new `*.lua` file returning a lazy spec.

### Plugins

| File | Plugin | Purpose |
|---|---|---|
| `catppuccin.lua` | catppuccin | Colorscheme |
| `lualine.lua` | lualine | Statusline |
| `alpha.lua` | alpha-nvim | Start-screen dashboard |
| `neo-tree.lua` | neo-tree | File explorer sidebar |
| `telescope.lua` | telescope (+ ui-select) | Fuzzy finder for files, grep, help |
| `lsp-config.lua` | mason + mason-lspconfig + nvim-lspconfig | LSP servers (`lua_ls`, `tsserver`) |
| `completions.lua` | nvim-cmp + LuaSnip + friendly-snippets | Autocompletion & snippets |
| `none-ls.lua` | none-ls (null-ls) | Formatting/linting: stylua, black, isort, prettier, cppcheck, eslint |
| `treesitter.lua` | nvim-treesitter | Syntax highlighting/indent (lua, python, cpp, js, html, css, c#, json, markdown, bash) |
| `debugger.lua` | nvim-dap (+ dap-ui, dap-python, cppdbg) | Debugging for Python and C/C++ |
| `terminal.lua` | toggleterm | Toggleable integrated terminals |
| `copilot.lua` | copilot.vim + CopilotChat | AI completion & chat |
| `undotree.lua` | undotree | Visual undo history |
| `window-picker.lua` | nvim-window-picker | Jump to a window by letter |

### Key mappings

Leader is `<Space>`.

**Files & search (Telescope / Neo-tree)**

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>gr` | Live grep |
| `<leader>rf` | Recent files |
| `<leader>mp` | Man pages |
| `<leader>cs` | Pick colorscheme |
| `<C-n>` | Open Neo-tree |
| `<leader>n` | Close Neo-tree |
| `<leader>w` | Pick window |

**LSP & editing**

| Key | Action |
|---|---|
| `K` | Hover docs |
| `gd` | Go to definition |
| `<leader>ca` | Code action |
| `<leader>fd` | Format buffer |
| `<leader>z` | Toggle undotree |
| `<leader>cc` | Toggle CopilotChat |

**Completion menu (insert mode):** `<C-Space>` trigger, `<CR>` confirm, `<C-e>` abort, `<C-b>`/`<C-f>` scroll docs.

**Terminal (toggleterm):** `<C-\>` toggle; `<leader>th` horizontal, `<leader>tv` vertical, `<leader>tf` float, `<leader>ta` toggle all, `<leader>t1`/`t2`/`t3` specific terminals. Inside a terminal, `<esc>` or `jk` returns to normal mode.

**Debugging (nvim-dap):** `<leader>db` breakpoint, `<leader>dc` continue, `<leader>dn` step over, `<leader>di` step into, `<leader>do` step out, `<leader>dr` restart, `<leader>dx` close.

> **Note:** The debugger expects a Python debug env at `~/.virtualenvs/debugpy` and, for C/C++, prefers a Mason-installed `OpenDebugAD7`, falling back to `~/extension/debugAdapters/bin/OpenDebugAD7`. Adjust `nvim/lua/plugins/debugger.lua` if your paths differ.

### Updating plugins

Plugin versions are pinned in `lazy-lock.json`. To upgrade, run `:Lazy update` in nvim (this rewrites the lockfile), then commit the updated `lazy-lock.json`.

## iTerm2 Preferences

### NerdFonts (optional)

For icon support in tmux, install NerdFonts and apply it in iTerm2:

```bash
brew install --cask font-hack-nerd-font
```

1. Open iTerm2
2. Go to **Settings > Profiles > Text**
3. Set Font to `DroidSansMono Nerd Font`

### Import settings

### Import via iTerm2 (recommended)

1. Open iTerm2
2. Go to **Settings > General > Settings**
3. Select **Import All Settings and Data...**
4. Select `iterm2/iTerm2 State.itermexport` from this repo

This imports profiles, colors, key bindings, and all other preferences.

### Manual plist install

Copy the preferences file directly to macOS's preferences directory:

```bash
cp iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
```

Then restart iTerm2 for the changes to take effect.
