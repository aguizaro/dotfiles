return {
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			local win = require("window-picker")
			win.setup({
				hint = "floating-big-letter",
			})

            vim.api.nvim_set_keymap("n", "<leader>w", ":lua require('window-picker').pick_window()<CR>", { noremap = true, silent = true })
		end,
	},
}
