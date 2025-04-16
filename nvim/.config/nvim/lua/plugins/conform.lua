return {
    'stevearc/conform.nvim',
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    opts = {
        formatters_by_ft = {
            python = function(bufnr)
                -- if require("conform").get_formatter_info("ruff_format", bufnr).available then
                --     return { "ruff_format" }
                -- else
                    return { "isort", "black" }
                -- end
            end,
        },
        format_on_save = false,
    },
    keys = {
        { '<leader>lf', function() require("conform").format({ lsp_fallback = true, async = true, timeout = 500 }) end, mode = "", desc = "Format buffers" }
    }
}
