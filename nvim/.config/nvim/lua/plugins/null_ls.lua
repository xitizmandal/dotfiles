local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local command_resolver = require("null-ls.helpers.command_resolver")

-- register any number of sources simultaneously
local sources = {
    formatting.black.with {
        prefer_local = true,
        command = vim.fn.expand('~/.pyenv/versions/nvim/bin/black'),
        timeout = 5000,
    },
    -- null_ls.builtins.diagnostics.pylint,
    formatting.isort.with {
        prefer_local = true,
        command = vim.fn.expand('~/.pyenv/versions/nvim/bin/isort')
    },
    -- diagnostics.mypy.with {
        -- prefer_local = true,
        -- command = vim.fn.expand('~/.pyenv/versions/nvim/bin/mypy')
    -- },
    diagnostics.flake8.with {
        prefer_local = true,
        -- command = vim.fn.expand('~/.pyenv/versions/nvim/bin/pylint'),
        -- diagnostics_format = "[#{c}] #{m} (#{s})"
        -- diagnostics_postprocess = function(diagnostic)
        --     if diagnostic.severity == vim.diagnostic.severity.ERROR then
        --         diagnostic.severity = vim.diagnostic.severity.WARN
        --     end
        -- end
    },
    -- null_ls.builtins.code_actions.eslint
    formatting.eslint_d.with {
        prefer_local = 'node_modules/.bin',
    },
    diagnostics.eslint_d.with {
        prefer_local = 'node_modules/.bin',
    },
    code_actions.eslint_d.with {
        prefer_local = 'node_modules/.bin',
    },
    -- null_ls.builtins.formatting.prettier.with {
    --     prefer_local = 'node_modules/.bin',
    --     filetypes = {
    --         'typescriptreact',
    --         'typescript',
    --         'javascriptreact',
    --         'javascript',
    --         'svelte',
    --         'json',
    --         'jsonc',
    --         'css',
    --         'less',
    --         'scss',
    --         'html',
    --         'yaml',
    --     },
    -- },
}

null_ls.setup({
    sources = sources,
    fallback_severity = vim.diagnostic.severity.HINT,
})
