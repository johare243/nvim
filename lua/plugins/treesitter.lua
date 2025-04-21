-- lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build  = ":TSUpdate",
    opts   = {
      ensure_installed = { "lua", "bash", "python", "javascript" },
      highlight        = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
