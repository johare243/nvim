-- lua/config/keymaps.lua
-- Key mappings and leader shortcuts
local km = vim.keymap.set
local opts = { noremap = true, silent = true }

local function close_or_quit()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  if #listed <= 1 then
    vim.cmd("qa") -- or ":q" if you only want to close the current tab
  else
    vim.cmd("bd!")
  end
end

local function quit_all()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
    vim.cmd("qall!")
end

local function write_close_or_quit()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  if #listed <= 1 then
    vim.cmd("wqa") -- or ":q" if you only want to close the current tab
  else
    vim.cmd("wbd!")
  end
end

vim.keymap.set('n', '<C-@>', '<NOP>', opts)
-- run tmux-sessionizer
km("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- open the alternate (last) buffer in a vertical split
vim.keymap.set('n', '<leader>\\', '<cmd>vsplit #<CR>', opts)
-- open the alternate (last) buffer in a horizontal split
vim.keymap.set('n', '<leader>-', '<cmd>split #<CR>', opts)

-- close the current window (buffer stays loaded in background / bufferline)
vim.keymap.set('n', '<leader>c', '<cmd>close<CR>', opts)
-- Save file
km("n", "<leader>w", ":w<CR>", opts)
km("n", "<leader>W", write_close_or_quit, opts)

-- Keep copied text when deleting
-- (yy then dd a line, can still use p to paste yanked line)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Source file
km("n", "<leader><leader>", ":so<CR>", opts)

-- Next buffer/prev buffer
km("n", "<leader>n", ":bnext<CR>", opts)
km("n", "<leader>l", ":bprev<CR>", opts)

-- Delete current buffer
km("n", "<leader>q", ":bd<CR>:bprev<CR>", opts)
km("n", "<leader>Q", close_or_quit, opts)
km('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
km('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
km('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
km('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

km("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Move line below to end of current line
km("n", "J", "mzJ`z")

-- Move highlighted lines up and down
km("v", "J", ":m '>+1<CR>gv=gv")
km("v", "K", ":m '<-2<CR>gv=gv")

-- yank to clipboard
km({ "n", "v" }, "<leader>y", [["+y]], { desc = '[Y]ank to system clipboard' })

-- format file from lsp
km("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat file" })

-- search and replace entire file
km("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = '[S]earch and replace entire file' })


-- Telescope core
km("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "[S]earch [F]iles" })
km("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "[S]earch by [G]rep" })
km("n", "<leader>sb", "<cmd>Telescope buffers<cr>", { desc = "[S]earch [B]uffers" })
km("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "[S]earch [H]elp" })
km("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "[S]earch [K]eymaps" })
km("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "[S]earch [R]ecent files" })
km("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy search in buffer" })

