require("vim-options") --  Loads vim options. Plugins use lazy file.
require("keymaps") -- Loads default keymaps.Plugins use lazy file.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke.lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")
