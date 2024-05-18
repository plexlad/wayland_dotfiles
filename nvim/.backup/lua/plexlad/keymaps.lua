local opts = { noremap = true, silent = true }
local km = vim.api.nvim_set_keymap

km("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
km("n", "<C-h>", "<C-w>h", opts)
km("n", "<C-j>", "<C-w>j", opts)
km("n", "<C-k>", "<C-w>k", opts)
km("n", "<C-l>", "<C-w>l", opts)

--km("n", "<leader>e", ":vsplit<CR>:Oil<CR>", opts) -- Open file explorer to the left
km("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- Open file explorer to the left

-- Split windows
km("n", "<leader>wv", ":vertical split<CR>", opts)
km("n", "<leader>wh", ":split<CR>", opts)

-- Tab navigation
km("n", "<leader>n", ":tabnew<CR>", opts)
km("n", "<S-l>", ":tabnext<CR>", opts)
km("n", "<S-h>", ":tabprevious<CR>", opts)

-- Resize with arrows
km("n", "<C-Up>", ":resize +2<CR>", opts)
km("n", "<C-Down>", ":resize -2<CR>", opts)
km("n", "<C-Right>", ":vertical resize +2<CR>", opts)
km("n", "<C-Left>", ":vertical resize -2<CR>", opts)

-- Insert --
-- Press jk fast to exit
km("i", "jk", "<ESC>", opts)
-- Autobrackets
--km("i", '"', '""<left>', opts)
--km("i", "'", "''<left>", opts)
--km("i", "(", "()<left>", opts)
--km("i", "[", "[]<left>", opts)
--km("i", "{", "{}<left>", opts)
--km("i", "{<CR>", "{<CR>}<ESC>O", opts)
--km("i", "{;<CR>", "{<CR>};<ESC>O", opts)

-- Copying and Pasting --
km("v", "<leader>d", "_d<CR>", opts)

-- Plugins --
-- toggleterm (terminal functionalit)
km("n", "<leader>th", ":ToggleTerm size=15 direction=horizontal<CR>", opts) -- Horizontal terminal
km("t", "<Esc>", "<C-\\><C-n>:q<CR>", opts)

-- Telescope shortcuts
km("n", "<leader>sf", ":Telescope find_files<CR>", opts)
km("n", "<leader>st", ":Telescope current_buffer_fuzzy_find<CR>", opts)

-- folke plugins
-- trouble
km("n", "<leader>t", ":Trouble<CR>", opts)

-- Undotree
km("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- Fugitive (Git functionality)
km("n", "<leader>g", ":Git ", { noremap = true })
