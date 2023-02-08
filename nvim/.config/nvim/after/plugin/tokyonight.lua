require("tokyonight").setup({
    style = "night",
    transparent = true,
    terminal_colors = true,
    styles = {
        functions = "italic",
        sidebars = "transparent",
        floats = "transparent",
    },
    sidebars = { "telescope", "nvim-tree", "outline" },
    dim_inactive = true,
    hide_inactive_statusline = false,

})

vim.cmd.colorscheme("tokyonight")
