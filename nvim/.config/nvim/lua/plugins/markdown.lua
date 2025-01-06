return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    -- enabled=false,
    opts = {
        -- render_modes = {'n', 'c', 't' },
        render_modes = true,
        -- heading = {
        --     sign = true,
        --     position = "inline",
        --     -- border = true,
        --     -- border_virtual=true,
        --     -- width="block",
        --     -- left_pad=2,
        --     -- right_pad=2,
        -- },
        heading = {
            enabled = true,
            sign = true,
            position = 'overlay',
            -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
            icons = { '󰼏 ', '󰎨 ' },
            signs = { '󰫎 ' },
            width = 'full',
            left_margin = 0,
            left_pad = 0,
            right_pad = 0,
            min_width = 0,
            border = false,
            border_virtual = false,
            border_prefix = false,
            above = '▄',
            below = '▀',
            backgrounds = {
                'RenderMarkdownH1Bg',
                'RenderMarkdownH2Bg',
                'RenderMarkdownH3Bg',
                'RenderMarkdownH4Bg',
                'RenderMarkdownH5Bg',
                'RenderMarkdownH6Bg',
            },
            foregrounds = {
                'RenderMarkdownH1',
                'RenderMarkdownH2',
                'RenderMarkdownH3',
                'RenderMarkdownH4',
                'RenderMarkdownH5',
                'RenderMarkdownH6',
            },
        },
        quote = { repeat_linebreak = true },
        checkbox = {
            -- position="overlay",
        },
        code = {
            -- width = "block",
            -- position = "right",
            -- min_width = 45,
            -- sign=false,
            -- style = "normal",
            -- left_pad = 2
        },
        -- indent = {
        --     -- 	enabled=true,
        -- },
        -- sign = {
        --     enabled = false,
        -- },
        latex = {
            enabled = true,
            converter = 'latex2text',
            highlight = 'RenderMarkdownMath',
            top_pad = 0,
            bottom_pad = 0,
        },
        bullet = {
            icons = { '●', '○', '◆', '◇' },
        },
        overrides = {
            buftype = {
                nofile = { enabled = false },
            },
        },
    },
}
