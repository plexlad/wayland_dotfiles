o = vim.opt
c = vim.cmd

o.backup = false
o.clipboard = "unnamedplus"
o.cmdheight = 2
o.completeopt = { "menuone", "noselect" }
o.conceallevel = 0
o.fileencoding = "utf-8"

o.hlsearch = false
o.incsearch = true
o.ignorecase = true

o.mouse = "a"
o.pumheight = 10

o.showtabline = 2
o.smartcase = true
o.smartindent = true
o.splitbelow = true

o.splitright = true
o.swapfile = false
o.termguicolors = true
o.timeoutlen = 1000

o.colorcolumn = "80"

o.undofile = true
o.undodir = os.getenv("HOME") .. "/.vim/undodir"

o.updatetime = 300
o.writebackup = true

o.expandtab = true
o.shiftwidth = 4
o.smarttab = true
o.tabstop = 4
o.softtabstop = 0

o.number = true
o.relativenumber = true

o.signcolumn = "yes"
o.wrap = true
o.scrolloff = 8
o.sidescrolloff = 8
o.guifont = "JetbrainsMono Nerd Font"
