return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require('barbar').setup({
        animation = true,
        clickable = true,
        icons = {
          filetype = { enabled = true },
        },
      })

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Move to previous/next tab
      map('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
      map('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', opts)

      -- Close the current tab
      map('n', '<leader>w', '<Cmd>BufferClose<CR>', { desc = "Close Tab/Buffer" })
    end,
    opts = {},
    version = '^1.0.0',
  },
}
