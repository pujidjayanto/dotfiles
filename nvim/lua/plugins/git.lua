return {
  -- Fugitive: For major operations (Commit, Push, Blame, Merge)
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status Panel" })
      vim.keymap.set("n", "<leader>gp", function() vim.cmd("Git push") end, { desc = "Git Push" })
    end,
  },

  -- Gitsigns: Visualizes changes in the gutter (sidebar) as you type
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        current_line_blame = true, -- Shows who wrote the active line inline
      })
    end,
  },
}
