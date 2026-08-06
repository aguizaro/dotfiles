return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>gr", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>mp", builtin.man_pages, {})
			vim.keymap.set("n", "<leader>cs", builtin.colorscheme, {})
			vim.keymap.set("n", "<leader>op", builtin.vim_options, {})
			vim.keymap.set("n", "<leader>rf", builtin.oldfiles, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
