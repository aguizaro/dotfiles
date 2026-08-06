return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mxsdev/nvim-dap-vscode-js",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dap.set_log_level("DEBUG")
		dapui.setup()

		require("dap-python").setup("/Users/tonyguizar/.virtualenvs/debugpy/bin/python")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		--dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
		-- dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "/Users/tonyguizar/extension/debugAdapters/bin/OpenDebugAD7",
		}
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dc", dap.continue, {})
		vim.keymap.set("n", "<leader>dr", dap.restart, {})
		vim.keymap.set("n", "<leader>dn", dap.step_over, {})
		vim.keymap.set("n", "<leader>di", dap.step_into, {})
		vim.keymap.set("n", "<leader>do", dap.step_out, {})
		vim.keymap.set("n", "<leader>dx", dap.close, {})
	end,
}
