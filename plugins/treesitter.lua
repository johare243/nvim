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
              ensureinstalled = { 
                  "lua", "vim", "vimdoc", "bash", "markdown", "markdown_inline", 
                  "apex", "soql", "sosl", "sflog"
              },
          })
      end
}
