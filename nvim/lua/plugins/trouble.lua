return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		local trouble = require("trouble")
		trouble.setup({
			signs = {
				error = "✘",
				warning = "▲",
				hint = "⚑",
				information = "",
				other = "",
			},
		})

		vim.keymap.set("n", "<leader>gt", function()
			trouble.toggle()
		end)
	end,
}
