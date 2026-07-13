# Dotfiles

A minimal Neovim setup to learn and observe the behavior of each plugin, gradually building understanding until I find the best configuration that works for me.

### Why This Setup

I'm learning Neovim by starting small, keeping the plugin count low and the config readable so I can understand what each piece does before adding more. The goal is to get comfortable with the core workflow first, then evolve the setup over time based on what actually helps me.

Each plugin lives in its own file so I can easily add, remove, or tweak things as I go without breaking the rest.

### Structure

```
nvim/
├── init.lua
├── lua/
│   ├── base/
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── lazy.lua
│   └── plugins/
│       ├── theme.lua
│       ├── lualine.lua
│       ├── nvim-tree.lua
│       ├── telescope.lua
│       ├── tabs.lua
│       ├── lsp.lua
│       └── git.lua
```

### Config & Plugins Rationale

**Base Config**

- **init.lua** — The entry point Neovim reads on startup. It just loads the three base modules in order so everything stays organized in one place.
- **base/options.lua** — Editor behavior base settings (tab width, line numbers, clipboard). Separated so I can tweak editor feel without touching keymaps or plugins.
- **base/keymaps.lua** — Global keybindings that don't depend on any plugin (leader key, window navigation, clearing search). Kept apart from plugin-specific keymaps so I know which bindings are "mine" vs which come from a plugin.
- **base/lazy.lua** — Bootstraps the plugin manager and tells it to auto-discover everything inside `lua/plugins/`. This means adding a new plugin is just dropping a file in that folder — no need to touch any other file.


**Plugins**

- **[lazy.nvim](https://github.com/folke/lazy.nvim)** — Plugin manager. Auto-installs on first launch, lazy-loads where possible to keep startup fast.
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** — Colorscheme. Uses the "storm" variant with transparent backgrounds so it blends with my terminal (Kitty).
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** — Status line. Minimal config, theme-aware, shows mode/file/git info at a glance.
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** — File explorer. Opens on the left with `Ctrl+b` (same muscle memory as VS Code). Auto-opens when launching Neovim without a file argument.
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** — Fuzzy finder for files (`<leader>ff`) and text search (`<leader>fg`). Ignores `node_modules`, `.git`, `build`, and `dist` by default. Uses fzf-native for sorting speed.
- **[barbar.nvim](https://github.com/romgrk/barbar.nvim)** — Tabline/bufferline. Gives VS Code-style tabs with `Tab`/`Shift+Tab` navigation and `<leader>w` to close.
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** — Portable LSP server installer. Manages `gopls`, `ruby_lsp`, and `vtsls` so language tooling works out of the box without system-wide installs.
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** — Provides default configurations for language servers. Used with Neovim 0.11's native `vim.lsp.enable()` API.
- **[vim-fugitive](https://github.com/tpope/vim-fugitive)** — Git commands inside Neovim. `<leader>gs` for status, `<leader>gp` for push.
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** — Shows git diff markers in the sign column and inline blame on the current line.

### Key Bindings

Leader key: `Space`

- `<C-b>` — Toggle file explorer
- `<leader>ff` — Find files
- `<leader>fg` — Live grep (search text)
- `<Tab>` / `<S-Tab>` — Next / previous buffer tab
- `<leader>w` — Close current buffer
- `gd` — Go to definition
- `K` — Hover documentation
- `<leader>ca` — Code actions
- `<C-LeftMouse>` — Ctrl+Click go to definition
- `<leader>gs` — Git status
- `<leader>gp` — Git push
- `<C-h/j/k/l>` — Navigate between splits
- `<Esc>` — Clear search highlights

### Requirements

- Neovim >= 0.11
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for file icons
- `make` (for telescope-fzf-native compilation)
- Node.js (for vtsls)
- Go (for gopls)
- Ruby (for ruby_lsp)

### Installation

```bash
# Back up your existing config if needed
mv ~/.config/nvim ~/.config/nvim.bak

# Symlink this config
ln -s ~/path/to/dotfiles/nvim ~/.config/nvim

# Open Neovim — plugins install automatically on first launch
nvim
```

Mason will download and install the configured language servers on first open. No manual `:MasonInstall` needed.
