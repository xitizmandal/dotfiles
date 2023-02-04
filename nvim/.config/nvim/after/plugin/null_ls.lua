local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local command_resolver = require("null-ls.helpers.command_resolver")

-- register any number of sources simultaneously
local sources = {
    formatting.black,
    formatting.isort,
    diagnostics.flake8.with {
        prefer_local = true,
    },
    formatting.eslint_d,
    diagnostics.eslint_d,
    code_actions.eslint_d,
    formatting.prettier
}

null_ls.setup({
    sources = sources,
    fallback_severity = vim.diagnostic.severity.HINT,
})
