return {
  "nvim-treesitter/nvim-treesitter",
branch = 'master',
lazy = false,
build = ":TSUpdate",
config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      autoinstall = true,
      ensureinstalled = {
        "sflog", "apex", "soql", "sosl",
        "lua", "vim", "vimdoc", "bash", "markdown", "markdown_inline",
      },
    })
  end
}
