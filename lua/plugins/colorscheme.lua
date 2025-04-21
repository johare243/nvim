-- lua/plugins/colorscheme.lua
-- 
return {
  {
    "catppuccin/nvim",
    name     = "catppuccin",
    priority = 1000,
    lazy     = false,
    config   = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    name     = "gruvbox",
    priority = 1000,
    lazy     = false,
    config   = function()
      require("gruvbox").setup({ contrast = "hard" })
    end,
  },
  {
    "Yazeed1s/oh-lucy.nvim",
    name = "oh-lucy",
    priority = 1000,
    lazy = false,
   -- config = function()
   --   require("oh-lucy").setup({})
  --  end,
  }
}
