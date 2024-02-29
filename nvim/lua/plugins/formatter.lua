return {
	{
		'mhartington/formatter.nvim',
		config = function ()
			require('formatter').setup {

            }
            -- Creates an autogroup and sets a command to auto format to write
            vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
                pattern = '*',
                group = 'FormatAutogroup',
                command = 'FormatWrite'
            })
		end,
	},
	'nvim-tree/nvim-web-devicons',
}
