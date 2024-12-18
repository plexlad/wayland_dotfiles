-- Set the leader key --
vim.g.mapleader = " "
vim.g.localmapleader = " "

-- Lazy Package Manager --
-- Colorscheme is set here with the config as well
require("config.lazy") -- Install and run lazy

require("vim-options") --  Loads vim options. Plugins use lazy file.
require("keymaps") -- Loads default keymaps.Plugins use lazy file.

vim.o.background = "dark"
