vim.g.mapleader = " "
vim.g.maplocalleader = " "

local m = vim.keymap.set

-- special
m("v", "J", ":m '>+1<CR>gv=gv")
m("v", "K", ":m '<-2<CR>gv=gv")
m("x", "<leader>p", [["_dP]])
m({ "n", "v" }, "<leader>y", [["+y]])
m("n", "<leader>Y", [["+Y]])
m({ "n", "v" }, "<leader>d", [["_d]])
m("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
m("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- basics
m("n", "<leader><leader>", "<cmd>source %<cr>", { desc = "Source current file" })
m("n", "<leader>ww", "<cmd>w<cr>", { desc = "Save" })
m("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
m("n", "<leader>qa", "<cmd>qall<cr>", { desc = "Quit All" })

-- movement QoL
m("n", "<leader>n", "<cmd>bnext<cr>", { desc = "Next Buffer" })
m("n", "<leader>p", "<<cmd>bprev<cr>", { desc = "Previous Buffer" })
m("n", "<C-d>", "<C-d>zz", { desc = "Half page down (center)" })
m("n", "<C-u>", "<C-u>zz", { desc = "Half page up (center)" })

-- harpoon
m("n", "<leader>h", "<cmd>harpoon.ui.toggle_quick_menu()<cr>", { desc = "Next Buffer" })


-- window navigation (requested)
m("n", "<C-h>", "<C-w>h", { desc = "Window left" })
m("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- explorer (nvim-tree)
m("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
m("n", "<leader>ec", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Toggle Current File in File Explorer" })
m("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
m("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffer" })
m("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep in CWD" })
