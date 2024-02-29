return {
  -- Themes -- 
	{
		"morhetz/gruvbox",
		priority = 9999,
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end
	},

  -- Dependancies --
	{ "nvim-lua/plenary.nvim" },

  -- Neat plugins
	{ "nvim-telescope/telescope.nvim" },
  { -- Auto bracket pairing
    "m4xshen/autoclose.nvim",
		config = function ()
			require("autoclose").setup()
		end
  },
-- File Manager
{ "nvim-tree/nvim-web-devicons" },
	{ 
		"nvim-tree/nvim-tree.lua",
		config = function ()
			vim.g.loaded_netrw, vim.g.loaded_netrwPlugin = 1, 1
			require("nvim-tree").setup()
		end
	},
--  {
--      "stevearc/oil.nvim",
--      opts = {},
--      dependencies = { "nvim-tree/nvim-web-devicons" },
--  },
  {
	  "nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    config = function ()
      require("nvim-treesitter.configs").setup {
        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
          },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "grr",
            },
          },
        },
      }
    end
  },
	{
		'stevearc/aerial.nvim',
		opts = {},
		-- Optional dependencies
		dependencies = {
			 "nvim-treesitter/nvim-treesitter",
			 "nvim-tree/nvim-web-devicons",
		},
	},
	{ "mbbill/undotree"},
  { "tpope/vim-fugitive"},
  { "michaelb/do-nothing.vim", lazy = true },
  { "folke/trouble.nvim" },
  { "m4xshen/autoclose.nvim" },

  -- HTML
	{ "alvan/vim-closetag" },	-- Closes HTML tags
	{ "norcalli/nvim-colorizer.lua",
		lazy = true, -- Adds color visualizer!
  },

  -- LSP and Autocompletion --
	{ "hrsh7th/nvim-cmp" },
  {
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
	},
	{	"neovim/nvim-lspconfig" },
	{	"hrsh7th/nvim-cmp" },
	{	"hrsh7th/cmp-nvim-lsp" },
	{	"hrsh7th/cmp-nvim-lua" },
	{	"L3MON4D3/LuaSnip" },
	{ "williamboman/mason.nvim", lazy = true },
	{ "williamboman/mason-lspconfig.nvim", lazy = true },

	-- Terminal
	{ "akinsho/toggleterm.nvim", version = "*", config = true },

    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}},
}
