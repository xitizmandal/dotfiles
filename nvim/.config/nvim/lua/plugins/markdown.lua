return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    -- enabled=false,
    opts = {
        -- render_modes = {'n', 'c', 't', 'i'},
        render_modes = true,
        heading = {
            -- sign=false,
            position = "inline",
            border = true,
            -- border_virtual=true,
            -- width="block",
            -- left_pad=2,
            -- right_pad=2,
        },
        checkbox = {
            -- position="overlay",
        },
        code = {
            -- width = "block",
            -- position = "right",
            -- min_width = "4",
            -- sign=false,
        },
        indent = {
            -- 	enabled=true,
        },
        sign = {
            enabled = false,
        },
    },
}
