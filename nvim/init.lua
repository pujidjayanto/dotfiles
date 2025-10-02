-----------------------------------------------------------
-- BASIC SETTINGS
-----------------------------------------------------------
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.clipboard = "unnamedplus" -- system clipboard
vim.opt.nu = true                 -- show line numbers

vim.g.mapleader = " "             -- leader key = space


-----------------------------------------------------------
-- BOOTSTRAP lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)


-----------------------------------------------------------
-- PLUGINS
-----------------------------------------------------------
require("lazy").setup({
  spec = {
    -- UI
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    -- LSP + Completion
    -- mason will install the lsp instead of manually install
    -- a portable package manager used to easily install and manage editor tools like Language Server Protocol (LSP) servers, Debug Adapter Protocol (DAP) servers, linters, and formatters
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim" },

    -- Autocompletion engine
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
    },
  },
  checker = { enabled = true },
})


-----------------------------------------------------------
-- UI PLUGINS CONFIG
-----------------------------------------------------------
-- Lualine
require("lualine").setup()

-- Nvim-tree
require("nvim-tree").setup({
  view = { width = 50, side = "right" },
  update_focused_file = { enable = true, update_cwd = true },
})
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle Explorer" })
vim.keymap.set("n", "<leader>n", function() require("nvim-tree.api").tree.focus() end, { desc = "Focus Explorer" })

-- Telescope
require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})
require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search text" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })


-----------------------------------------------------------
-- AUTOCOMPLETION (nvim-cmp)
-----------------------------------------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(), -- trigger completion
    ["<C-e>"] = cmp.mapping.abort(),        -- close completion
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- accept completion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll docs up
    ["<C-f>"] = cmp.mapping.scroll_docs(4),  -- scroll docs down
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})


-----------------------------------------------------------
-- LSP (Mason + TS/JS/TSX)
-----------------------------------------------------------
require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = { "ts_ls" }, -- Mason server name
  automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use ts_ls to avoid deprecation warning
vim.lsp.enable("ts_ls", {
  capabilities = capabilities,
})


-- LSP keymaps
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
