vim.g.mapleader = " "
vim.g.maplocalleader = " "

local m = vim.keymap.set

m("v", "<C-j>", ":m '>+1<CR>gv=gv")
m("v", "<C-k>", ":m '<-2<CR>gv=gv")
m("x", "<leader>p", [["_dP]])


-- parens for adv360
m("i", "<Left>", "(")
m("i", "<Right>", "{")
m("i", "<Up>", "}")
m("i", "<Down>", ")")

-- special
-- yank to clipboard
m({ "n", "v" }, "<leader>y", [["+y]])
m("n", "<leader>Y", [["+Y]])

-- delete to null register
m({ "n", "v" }, "<leader>d", [["_d]])

-- tmux commands
m("n", "<C-p>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- basics
m("i", "jk", "<ESC>", { desc = "Escape" }) -- I never use this but maybe one day
m("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
m("n", "<leader><CR>", "<cmd>source %<cr><cmd>lua print('source %')<CR>", { desc = "Source current file" })
m("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })


--
-- FUNCTIONS
--
-- add ; to the end of the line
m("n", "<leader>a", function()
  --local line = vim.fn.getline(.)
  --local last_char = string.sub(line, -1)
  local last_char = vim.fn.getline('.'):sub(-1)
  print(last_char)

  if last_char == ';' then
    return ''
  else
    return 'A;<Esc>'
  end
end, { expr = true, desc = "Add semicolon to end of line if not already there" });



m("n", "<leader>bd", function()
  -- Check if there are multiple windows
  local windows = vim.api.nvim_list_wins()
  if #windows > 1 then
    -- In a split: just close the window, keep buffer
    vim.cmd('close')
  else
    -- Single window: delete the buffer
    vim.cmd('bdelete!')
  end
end, { desc = "Smart Close Buffer" })

m("n", "<leader>q", function()
  -- Check if there are multiple windows
  local windows = vim.api.nvim_list_wins()
  if #windows > 1 then
    -- In a split: just close the window, keep buffer
    vim.cmd('close')
  else
    -- Single window: delete the buffer
    vim.cmd('bdelete!')
  end
end, { desc = "Smart Close Buffer" })

m("n", "<leader>bx", "<cmd>x<cr>", { desc = "Save if modified and quit" })

-- movement QoL
m("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
m("n", "<leader>bp", "<<cmd>bprev<cr>", { desc = "Previous Buffer" })
m("n", "<C-d>", "<C-d>zz", { desc = "Half page down (center)" })
m("n", "<C-u>", "<C-u>zz", { desc = "Half page up (center)" })

-- harpoon
m("n", "<leader>h", "<cmd>harpoon.ui.toggle_quick_menu()<cr>", { desc = "Next Buffer" })

-- explorer (nvim-tree)
m("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Toggle Current File in File Explorer" })

-- telescope
m("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
m("n", "<leader>fj", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
m("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffer" })
m("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep in CWD" })
m("n", "<leader>fw", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in current buffer" })
m("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })

-- split and pick buffer with telescope
m("n", "<leader>bv", function()
  vim.cmd('split')
  vim.cmd('Telescope buffers')
end, { desc = "Split Horizontal + Pick Buffer" })

m("n", "<leader>bh", function()
  -- Check if there's only one buffer (current buffer)
  local buffers = vim.api.nvim_list_bufs()
  local valid_buffers = {}
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
      table.insert(valid_buffers, buf)
    end
  end

  if #valid_buffers <= 1 then
    -- Use Telescope find_files with vertical split action
    require('telescope.builtin').find_files({
      attach_mappings = function(prompt_bufnr, map)
        local actions = require('telescope.actions')
        -- Override Enter to always open in vertical split
        map('i', '<CR>', function()
          actions.select_vertical(prompt_bufnr)
        end)
        return true
      end,
    })
  else
    -- Use Telescope buffers with vertical split action
    require('telescope.builtin').buffers({
      attach_mappings = function(prompt_bufnr, map)
        local actions = require('telescope.actions')
        -- Override Enter to always open in vertical split
        map('i', '<CR>', function()
          actions.select_vertical(prompt_bufnr)
        end)
        return true
      end,
    })
  end
end, { desc = "Pick File/Buffer for Vertical Split" })
