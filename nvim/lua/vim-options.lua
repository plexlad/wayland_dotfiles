-- Defaults for setting options (makes it more intuitive)
local global = vim.g
local option = vim.o

global.mapleader = " "
global.localmapleader = " "

option.backup = false
option.clipboard = "unnamedplus"
option.number = true
option.relativenumber = true

option.expandtab = true
option.tabstop = 2
option.softtabstop = 2
option.shiftwidth = 2

option.hlsearch = false
option.ignorecase = true

option.swapfile = false
option.termguicolors = true

option.undofile = true
option.undodir = os.getenv("HOME") .. "/.vim/undodir"

option.signcolumn = "yes"
option.scrolloff = 8
option.sidescrolloff = 8
