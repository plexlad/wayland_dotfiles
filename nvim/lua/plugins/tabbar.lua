return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function () vim.g.barbar_auto_setup = false end,

  config = function ()
    require("barbar").setup({
      animation = false,
      tab_pages = false,
      clickable = false,
    })

    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    map("n", "<leader>q", "<Cmd>BufferDelete<CR>", opts)
    map("n", "<S-h>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<S-l>", "<Cmd>BufferNext<CR>", opts)
  end,
  version = "^1.0.0",
}
