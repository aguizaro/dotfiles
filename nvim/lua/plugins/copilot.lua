return {
	{
		"github/copilot.vim",
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken",     -- Only on MacOS or Linux
		opts = {
			debug = true,
		},

		config = function()
			local copilot = require("CopilotChat")
			copilot.setup({
				debug = true,
			})
			vim.api.nvim_set_keymap("n", "<leader>cc", ":CopilotChatToggle<CR>", { noremap = true, silent = true })
		end,
	},
}
