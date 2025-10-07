vim.g.mapleader = " "
vim.g.maplocalleader = " "

local m = vim.keymap.set

-- basics
m("n", "<leader>ww", "<cmd>w<cr>", { desc = "save"})
m("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit"})
m("n", "<leader>qa", "<cmd>qall<cr>", { desc = "Quit All"})

-- movement QoL
m("n", "<C-d>", "<C-d>zz", { desc = "Half page down (center)"})
m("n", "<C-u>", "<C-u>zz", { desc = "Half page up (center)"})

-- window navigation (requested)
m("n", "<C-h>", "<C-w>h", { desc = "Window left"})
m("n", "<C-l>", "<C-w>l", { desc = "Window right"})

-- explorer (nvim-tree)
m("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer"})
m("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {desc = "Find Files"})
