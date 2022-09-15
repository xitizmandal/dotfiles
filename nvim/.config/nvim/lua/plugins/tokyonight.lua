-- vim.g.tokyonight_sytle = "night"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_transparent = true

-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_colors = {
--     bg_float = "none"
-- }

-- vim.g.tokyonight_dark_float = false

require("tokyonight").setup({
    style = "night",
    transparent = true,
    terminal_colors = true,
    styles = {
        functions = {
            italic = true,
        },
        sidebars = "transparent",
        floats = "transparent",
    },
    sidebars = { "telescope", "nvim-tree" },
    dim_inactive = true,
    hide_inactive_statusline = false,

})

vim.cmd [[colorscheme tokyonight]]
