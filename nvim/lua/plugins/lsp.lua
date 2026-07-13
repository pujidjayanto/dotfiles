return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      -- 1. Initialize Mason
      require("mason").setup()

      -- 2. Ensure your favorite language servers are downloaded
      local servers = { "gopls", "ruby_lsp", "vtsls" }
      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      -- 3. Modern Neovim 0.11+ Method to register and activate LSPs
      for _, server_name in ipairs(servers) do
        local cfg = vim.lsp.config[server_name]
        vim.lsp.config(server_name, cfg)
        vim.lsp.enable(server_name)
      end

      -- Keymaps
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set('n', '<C-LeftMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Ctrl + Click Go to Definition" })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show documentation" })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Actions" })
    end,
  },
}
