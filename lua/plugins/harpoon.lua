return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- if you're using the telescope UI
    },
    config = function()
      -- Initialize Harpoon2
      local harpoon = require("harpoon"):setup()

      -- Harpoon2 keymaps (only run once it's set up)
      vim.keymap.set("n", "<leader>h", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: Toggle Menu" })

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end, { desc = "Harpoon: Add File" })

      vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon: File 1" })

      vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon: File 2" })

      vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon: File 3" })

      vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon: File 4" })

      vim.keymap.set("n", "<C-h>", function()
        harpoon:list():prev()
      end, { desc = "Harpoon: Prev File" })

      vim.keymap.set("n", "<C-l>", function()
        harpoon:list():next()
      end, { desc = "Harpoon: Next File" })

      -- Telescope UI for Harpoon (optional)
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon Files",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      vim.keymap.set("n", "<C-e>", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Harpoon: Telescope UI" })
    end,
  },
}

