return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
      },
      filters = {
        dotfiles = false, -- Show hidden dotfiles (like .gitignore)
      },
    })

    -- Ctrl + b to toggle the sidebar (VS Code style)
    vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

    -- Automatically open the file tree when Neovim starts with no file argument
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argv(0) == "" or vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
          require("nvim-tree.api").tree.open()
        end
      end,
    })
  end,
}
