return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- Load immediately so your screen doesn't flicker
    priority = 1000, -- Load this before anything else
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })

      -- Tell Neovim to activate the theme
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },
}
