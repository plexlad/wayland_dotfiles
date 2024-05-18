local lsp = require('lsp-zero')
local cmp = require('cmp')
local cmp_format = lsp.cmp_format()
local cmp_action = lsp.cmp_action()

-- LSP-ZERO --
lsp.preset("recommended")

lsp.set_sign_icons({
	error = '✘',
  warn = '▲',
  hint = '⚑',
  info = ''
})

lsp.on_attach(function( _, bufnr )
	lsp.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		lsp.default_setup,
	}
})

lsp.setup()

-- CMP --
cmp.setup({
	preselect = 'item',
	sources = {
		{name = "nvim_lsp"},
		{name = "nvim_lua"},
		{name = 'luasnip'},
	},
	mapping = cmp.mapping.preset.insert({
		-- Keyboard shortcuts
		["<CR>"] = cmp.mapping.confirm({select = false}),
		['<Tab>'] = cmp_action.luasnip_supertab(),
		['<S-Tab'] = cmp_action.luasnip_shift_supertab(),
	}),
	formatting = cmp_format,
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	}
})
