-- Default keymaps
local opts = { noremap = true, silent = true }
local km = vim.api.nvim_set_keymap

vim.g.mapleader = " "
vim.g.localmapleader = " "

-- Navigation and Options --
-- Window Navigation
km("n", "<C-h>", "<C-w>h", opts)
km("n", "<C-j>", "<C-w>j", opts)
km("n", "<C-k>", "<C-w>k", opts)
km("n", "<C-l>", "<C-w>l", opts)

-- Window Split
km("n", "<leader>wv", ":vertical split<CR>", opts)
km("n", "<leader>wh", ":split<CR>", opts)
