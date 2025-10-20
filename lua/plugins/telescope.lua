local actions = require("telescope.actions")

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    defaults = {

      mappings = {
        i = {
          ["<C-j>"] = {
            actions.move_selection_next,
            type = "action",
            opts = { nowait = true, silent = true }
          },
          ["<C-k>"] = {
            actions.move_selection_previous,
            type = "action",
            opts = { nowait = true, silent = true }
          },
          ["<ESC>"] = {
            actions.close,
            type = "action",
            opts = { nowait = true, silent = true }
          },
          -- Open in splits
          ["<C-h>"] = actions.select_horizontal, -- Horizontal split
          ["<C-v'>"] = actions.select_vertical,  -- Vertical split
          ["<C-t>"] = actions.select_tab,        -- New tab
        },
        n = {
          -- Same mappings for normal mode in Telescope
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
        }
      },
    },
  },
}
