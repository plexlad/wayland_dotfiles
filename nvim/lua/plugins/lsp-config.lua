return {
  {
    "williamboman/mason.nvim",
    config = function ()
      require("mason").setup({
        providers = {
          "mason.providers.client",
          "mason.providers.registry-api"
        },
        log_level = vim.log.levels.DEBUG
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function ()
      require("mason-lspconfig").setup({
        -- Install lsp this way. Make sure to activate below.
        ensure_installed = { "nil_ls", "omnisharp" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      local lspconfig = require("lspconfig")
      -- Add config setups here
      lspconfig.lua_ls.setup({})
      lspconfig.nil_ls.setup({})
      lspconfig.omnisharp.setup({})
      vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end
  },
}
