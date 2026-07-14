return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 900,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      -- 1. Initialize Mason
      require("mason").setup()

      -- 2. Servers managed by Mason (auto-download)
      local mason_servers = { "gopls", "vtsls" }
      require("mason-lspconfig").setup({
        ensure_installed = mason_servers,
      })

      -- 3. Enable LSPs
      vim.lsp.enable("gopls")
      vim.lsp.enable("vtsls")
      vim.lsp.enable("ruby_lsp")

      -- Keymaps
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set('n', '<C-LeftMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Ctrl + Click Go to Definition" })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show documentation" })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Actions" })
    end,
  },
}
