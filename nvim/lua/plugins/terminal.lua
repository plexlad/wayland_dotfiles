return {
  "niuiic/terminal.nvim",
  config = function ()
    local open_vs_term = function ()
      vim.cmd("vsplit")
      require("terminal").open(0)
    end

    local open_hs_term = function ()
      vim.cmd("split")
      require("terminal").open(0)
    end

    vim.keymap.set("n", "<leader>th", open_hs_term, {})
    vim.keymap.set("n", "<leader>tv", open_vs_term, {})
  end
}
