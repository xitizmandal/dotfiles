return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = {
                    left = "",
                    right = "",
                },
                section_separators = {
                    left = "",
                    right = "",
                },
                disabled_filetypes = {},
                always_divide_middle = true,
                always_show_tabline = false,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    {
                        'filename',
                        path = 1,
                    }
                },
                -- TODO: change color
                lualine_c = {
                    'branch',
                    {
                        'diff',
                        colored = true,
                        symbols = {
                            added = '+',
                            modified = '~',
                            removed = '-',
                        }
                    }
                },
                lualine_x = {
                    'diagnostics',
                    'encoding',
                    {
                        'filetype',
                        colored = true
                    }
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },

            },
            inactive_sections = {
                lualine_a = {'mode'},
                lualine_b = {
                    {
                        'filename',
                        path = 1
                    }
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'location'}
            },
            tabline = {
                lualine_a = {
                    {
                        'buffers',
                        mode = 4
                    }
                },
                lualine_z = {
                    'tabs'
                }
            }
        })
    end
}
