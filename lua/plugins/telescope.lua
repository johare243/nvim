return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
            preview_width = 0.6,
          },
          sorting_strategy = "ascending",
          winblend = 0,
        },
      })
    end,
  },
}

