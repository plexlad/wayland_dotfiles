return {
  {
    -- The actual completion engine
    "hrsh7th/nvim-cmp",
    config = function ()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.scroll_docs(4),
          ["<C-j>"] = cmp.mapping.scroll_docs(-4),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space"] = cmp.mapping.complete(),
          ["<C-e"] = cmp.mapping.abort(),
--          ['<Tab>'] = cmp_action.luasnip_supertab(),
--          ['<S-Tab'] = cmp_action.luasnip_shift_supertab(),
        }),
        sources = cmp.config.sources({
          --{ name = "nvim_lsp" }
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })

      -- Used for custom lsp configuration
--      local capabilities = require('cmp_nvim_lsp').default_capabilities()
--      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--      require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--        capabilities = capabilities
--      }
    end
  },
  {
    -- The snippet expansion engine
    "L3MON4D3/LuaSnip",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Bridges cmp and autocomplete lsp features
      "saadparwaiz1/cmp_luasnip", -- Compatibility with cmp
      "rafamadriz/friendly-snippets", -- Nice vscode style snippets
    },
  },
}
