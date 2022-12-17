require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        -- disable = { "python" }
    },
    autotag = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    }
}
local rainbow = {
    "#d79921",
    "#a89984",
    "#b16286",
    "#458588",
    "#689d6a",
    "#d65d0e",
    "#cc241d",

}
for i, c in ipairs(rainbow) do -- p00f/rainbow#81
    vim.cmd(("hi rainbowcol%d guifg=%s"):format(i, c))
end

vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
