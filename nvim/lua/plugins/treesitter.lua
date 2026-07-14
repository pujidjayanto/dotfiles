return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "ruby", "go", "typescript", "javascript", "lua", "json", "yaml" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
