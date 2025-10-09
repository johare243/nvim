local c = vim.cmd
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    c.colorscheme("tokyonight")
  end,
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
}
