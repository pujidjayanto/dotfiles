-- vim tab setup
-- set tab size to 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- this is for yank and paste to another apps
vim.opt.clipboard = 'unnamedplus' -- use system keyboard for yank

-- this is for line numbers, i hate relative line number
vim.opt.nu = true                 -- set line numbers




-- Bootstrap lazy.nvim --------------------------
-- https://lazy.folke.io/installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
        {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
        {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- for file icons
    },
        {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- automatically check for plugin updates
  checker = { enabled = true },
})
-- Bootstrap lazy.nvim -----------------------------



-- setup plugins ----
-- lua line
require("lualine").setup()
-- configure nvim-tree
require("nvim-tree").setup({
  view = {
    width = 50,
    side = "right",
  },
  renderer = {
    icons = {
      show = {
        git = true,
        file = true,
        folder = true,
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
})
-- toggle nvim-tree like VSCode explorer
vim.api.nvim_set_keymap(
  "n",
  "<leader>e",
  ":NvimTreeToggle<CR>",
  { noremap = true, silent = true }
)

-- move focus from file to tree again
vim.keymap.set("n", "<leader>n", function()
  require("nvim-tree.api").tree.focus()
end, { desc = "Focus nvim-tree" })

-- configure nvim-tree
--
-- setup telescope with fzf
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim?tab=readme-ov-file#telescope-setup-and-configuration
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
-- setup telescope with fzf


--- setup plugins ----


