return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				providers = {
					"mason.providers.client",
					"mason.providers.registry-api",
				},
				log_level = vim.log.levels.DEBUG,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- Install lsp this way. Make sure to activate below.
				ensure_installed = { "nil_ls", "omnisharp", "gopls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
      local servers = { "tailwindcss", "tsserver" }
      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
        }
      end

			-- Add config setups here
			lspconfig.lua_ls.setup(capabilities)
			lspconfig.nil_ls.setup(capabilities)
			lspconfig.omnisharp.setup(capabilities)
			lspconfig.gopls.setup(capabilities)
      lspconfig.rust_analyzer.setup(capabilities)
			vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
