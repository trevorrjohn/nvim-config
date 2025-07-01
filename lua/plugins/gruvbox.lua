return {
	{
		"morhetz/gruvbox",
		lazy = false,
		config = function()
			vim.opt.background = "dark"
			vim.cmd.colorscheme("gruvbox")
		end
	},
}
