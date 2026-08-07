return {
	-- amongst your other plugins
	"akinsho/toggleterm.nvim",
	version = "*",
	-- or
	--	{ 'akinsho/toggleterm.nvim', version = "*", opts = { --[[ things you want to change go here]] } }

	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-\>]],
			direction = "vertical",
			size = 50,
			hide_numbers = true, -- Hide the number column in the terminal
			start_in_insert = true, -- Start in insert mode when terminal is opened
			insert_mappings = true, -- Allow opening terminal in insert mode
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = "-15", -- The degree of shading
		})

		-- Open a terminal in a horizontal split
		vim.api.nvim_set_keymap(
			"n",
			"<leader>th",
			":ToggleTerm direction=horizontal size=30<CR>",
			{ noremap = true, silent = true }
		)

		-- Open a terminal in a vertical split
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tv",
			":ToggleTerm direction=vertical<CR>",
			{ noremap = true, silent = true }
		)

		vim.api.nvim_set_keymap("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { noremap = true, silent = true })

		-- Keybinding to hide all terminals
		vim.api.nvim_set_keymap("n", "<leader>ta", ":ToggleTermToggleAll<CR>", { noremap = true, silent = true })

		-- Toggle to the terminal with terminal ID 1
		vim.api.nvim_set_keymap("n", "<leader>t1", ":ToggleTerm 1<CR>", { noremap = true, silent = true })

		-- Toggle to the terminal with terminal ID 2
		vim.api.nvim_set_keymap("n", "<leader>t2", ":ToggleTerm 2<CR>", { noremap = true, silent = true })

		-- Toggle to the terminal with terminal ID 3
		vim.api.nvim_set_keymap("n", "<leader>t3", ":ToggleTerm 3<CR>", { noremap = true, silent = true })

		vim.api.nvim_set_keymap("t", "<leader>tc", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true, silent = true })

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
