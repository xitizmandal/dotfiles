require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "python" }
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
        colors = {
            rainbowcol1 = "#d79921",
            rainbowcol2 = "#a89984",
            rainbowcol3 = "#b16286",
            rainbowcol4 = "#458588",
            rainbowcol5 = "#689d6a",
            rainbowcol6 = "#d65d0e",
            rainbowcol7 = "#cc241d",

        }, -- table of hex strings
        termcolors = {
            rainbowcol1 = 12,
            rainbowcol2 = 10,
            rainbowcol3 = 11,
            rainbowcol4 = 9,
            rainbowcol5 = 13,
            rainbowcol6 = 14,
            rainbowcol7 = 15,

        } -- table of colour name strings
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
