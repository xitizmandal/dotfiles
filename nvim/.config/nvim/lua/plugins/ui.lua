---
-- Tokyonight
-- nvim-web-devicons
--
---
return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
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
        end
    },
    -- nvim-web-devicons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.opt.list = true
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
            }
        end
    },
    -- { "lukas-reineke/virt-column.nvim",
    --     config = function()
    --         require("virt-column").setup({
    --
    --         })
    --     end
    -- },
    { 'nvim-lualine/lualine.nvim',
        config = function()
            require 'lualine'.setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        {
                            'filename',
                            path = 1,
                        }
                    },
                    lualine_c = { 'branch', 'diff', 'diagnostics' },
                    lualine_x = { 'encoding',
                        {
                            'filetype',
                            colored = true,
                        },
                    },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {
                    lualine_a = { { 'buffers', mode = 4 } },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { 'tabs' }
                },
                extensions = {}
            }
        end
    },

    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup()
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({})
        end
    },
}
