return {
  {
    -- The actual completion engine
    "hrsh7th/nvim-cmp",
    config = function ()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          -- Supertab functionality
          ["<CR>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
            if luasnip.expandable() then
                luasnip.expand()
            else
                cmp.confirm({ select = false })
            end
            else
                fallback()
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping.scroll_docs(4),
          ["<C-j>"] = cmp.mapping.scroll_docs(-4),
          ["<C-Space"] = cmp.mapping.complete(),
          ["<C-e"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })

      -- Used for custom lsp configuration
--      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--      require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--        capabilities = capabilities
--      }
      -- Adding omnisharp support
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
