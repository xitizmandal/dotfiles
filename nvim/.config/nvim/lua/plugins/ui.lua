---
-- Tokyonight
-- nvim-web-devicons
--
---
return {
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "dark",
                transparent = true,
                term_colors = true,
                code_styles = {
                    functions = "italic",
                    sidebars = "transparent",
                    floats = "transparent",
                },
                sidebars = { "telescope", "nvim-tree", "outline" },
                dim_inactive = true,
                hide_inactive_statusline = false,
                -- highlights = {
                --     Folded = { fg = '$fg', bg = '$bg2' },
                --     FoldColumn = { fg = "$fg", bg = "$bg2" }
                -- },
                diagnostics = {
                    darker = false,
                    background = false,
                }
            })

            require('onedark').load()
            -- vim.cmd.colorscheme("onedark")
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
            require("ibl").setup {
                scope = {
                    enabled = false,
                    priority = 500,
                    show_start = false,
                    show_end = false,
                    -- highlight = { "Function", "Label"}
                }
            }
        end
    },
    {
        "lukas-reineke/virt-column.nvim",
        config = function()
            require("virt-column").setup()
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            local function diff_source()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        removed = gitsigns.removed,
                        modified = gitsigns.changed,
                    }
                end
            end

            local kinds = require("symbols")
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
                    lualine_c = { 'branch',
                        {
                            'diff',
                            source = diff_source,
                            symbols = {
                                added = kinds["GitAdd"],
                                modified = kinds["GitModified"],
                                removed = kinds["GitDeleted"]
                            }
                        },
                        {
                            'diagnostics',
                            symbols = {
                                error = kinds["Error"],
                                warn = kinds["Warn"],
                                info = kinds["Info"],
                                hint = kinds["Hint"]
                            }
                        }
                    },
                    lualine_x = { 'encoding',
                        {
                            'filetype',
                            colored = true,
                        },
                        {
                            function()
                                local msg = 'No Active Lsp'
                                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                                local clients = vim.lsp.get_active_clients()
                                if next(clients) == nil then
                                    return msg
                                end
                                for _, client in ipairs(clients) do
                                    local filetypes = client.config.filetypes
                                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                        return client.name
                                    end
                                end
                                return msg
                            end,
                            icon = ' LSP:',
                            -- color = { fg = '#ffffff', gui = 'bold' },
                        }
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
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })

            local wk = require("which-key")
            wk.register({
                ["<leader>h"] = { name = "+Gitsigns" },
                ["<leader>f"] = { name = "+Telescope" },
                ["<leader>d"] = { name = "+Debugger" },
            })
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        -- event = { "InsertEnter" },
        dependencies = { "kevinhwang91/promise-async" },
        config = function()
            local ftMap = {
                vim = 'indent',
                python = { 'indent' },
                git = ''
            }
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ('... 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end
            require('ufo').setup({
                enable_get_fold_virt_text = true,
                open_fold_hl_timeout = 150,
                close_fold_kinds = { 'imports', 'comment' },
                preview = {
                    win_config = {
                        border = { '', '─', '', '', '', '─', '', '' },
                        winhighlight = 'Normal:Folded',
                        winblend = 0
                    },
                    mappings = {
                        scrollU = '<C-u>',
                        scrollD = '<C-d>',
                        jumpTop = '[',
                        jumpBot = ']'
                    }
                },
                provider_selector = function(bufnr, filetype, buftype)
                    -- if you prefer treesitter provider rather than lsp,
                    -- return ftMap[filetype] or {'treesitter', 'indent'}
                    return ftMap[filetype] or { 'treesitter', 'indent' }

                    -- refer to ./doc/example.lua for detail
                end,
                fold_virt_text_handler = handler
            })

            -- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            -- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            -- vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
            -- vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
            vim.keymap.set('n', 'zp', function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                -- if not winid then
                --     vim.lsp.buf.hover()
                -- end
            end)
        end,
        enabled=false,
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                relculright = true,
                bt_ignore = { "nofile", "neotree", "outline" },
                segments = {
                    {
                        text = { builtin.foldfunc, },
                        condition = { true, },
                        click = "v:lua.ScFa"
                    },
                    {
                        sign = {
                            name = { "Dap*" },
                            condition = { builtin.not_empty },
                            colwidth = 1
                        }
                    },
                    {
                        sign = {
                            name = { ".*" },
                            condition = { builtin.not_empty },
                            -- colwidth = 1
                        },
                    },
                    {
                        text = { builtin.lnumfunc },
                        click = "v:lua.ScLa",
                        colwidth = 2
                    },
                    {
                        sign = {
                            namespace = { "gitsigns" },
                            colwidth = 1,
                            wrap = true,
                            condition = { builtin.not_empty },
                        },
                    },
                }
            })
        end,
        enabled = true,
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    }
}
