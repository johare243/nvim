-- init.lua

-- 1) Set leaders up front
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- 2) Core Vim settings & mappings
require("config.options")
require("config.keymaps")

-- 3) Plugins (lazy.nvim bootstrap + specs)
require("config.lazy")

