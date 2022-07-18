local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
    null_ls.builtins.formatting.black.with {
        prefer_local = true,
        command = vim.fn.expand('~/.pyenv/versions/nvim/bin/black'),
        timeout = 5000,
    },
    -- null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.isort.with {
        prefer_local = true,
        command = vim.fn.expand('~/.pyenv/versions/nvim/bin/isort')
    },
    null_ls.builtins.diagnostics.flake8.with {
        prefer_local = true,
        command = vim.fn.expand('~/.pyenv/versions/nvim/bin/flake8'),
        -- diagnostics_format = "[#{c}] #{m} (#{s})"
        diagnostics_postprocess = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                diagnostic.severity = vim.diagnostic.severity.WARN
            end
        end
    },
}

null_ls.setup({ sources = sources })
