return {
  "windwp/nvim-ts-autotag",
  event = { "InsertEnter", "BufReadPost" },  -- only load when you start editing
  dependencies = {
    "nvim-treesitter/nvim-treesitter",      -- ensure Treesitter is installed
  },
  config = function()
    -- make sure Treesitter has the `autotag` module enabled
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "html", "javascript", "typescript", "tsx", "vue", "svelte" },
      highlight = { enable = true },
      autotag    = { enable = true },
    }
    -- plugin’s own setup (you can pass your own opts here)
    require("nvim-ts-autotag").setup {
      -- default filetypes; add/remove as you like
      filetypes = {
        "html", "xml", "javascript", "typescript", "typescriptreact",
        "javascriptreact", "svelte", "vue", "tsx",
      },
      -- you can tweak the tag closing logic here
      autotag = { enable = true,  -- auto rename both open/close
                 ignore_filetypes = { "txt", "markdown" },
      },
    }
  end,
}

