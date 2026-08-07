return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({ capabilities = capabilities })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			-- Define custom icons for LSP diagnostics
			vim.fn.sign_define(
				"DiagnosticSignError",
				{ text = "✘", numhl = "DiagnosticError", texthl = "DiagnosticSignError" }
			)
			vim.fn.sign_define(
				"DiagnosticSignWarn",
				{ text = "▲", numhl = "DiagnosticWarn", texthl = "DiagnosticSignWarn" }
			)
			vim.fn.sign_define(
				"DiagnosticSignInfo",
				{ text = "ℹ", numhl = "DiagnosticInfo", texthl = "DiagnosticSignInfo" }
			)
			vim.fn.sign_define(
				"DiagnosticSignHint",
				{ text = "⚑", numhl = "DiagnosticHint", texthl = "DiagnosticSignHint" }
			)
		end,
	},
}
