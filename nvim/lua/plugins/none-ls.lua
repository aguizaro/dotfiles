return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            debug = true,
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.completion.spell,
                null_ls.builtins.diagnostics.cppcheck,
                require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
            },
        })

        vim.keymap.set("n", "<leader>fd", vim.lsp.buf.format, {})
    end,
}
