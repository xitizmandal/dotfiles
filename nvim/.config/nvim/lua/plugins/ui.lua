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
                transparent = false,
                term_colors = true,
                code_styles = {
                    functions = "italic",
                    sidebars = "transparent",
                    floats = "transparent",
                },
                sidebars = { "telescope", "nvim-tree", "outline" },
                dim_inactive = true,
                hide_inactive_statusline = false,
                highlights = {
                    Folded = { fg = '$fg', bg = '$bg0' },
                    FoldColumn = { fg = "$fg", bg = "$bg0"}
                },
                diagnostics = {
                    darker = false,
                    background = false,
                }
                -- highlights = function(hl, c)
                --     hl.Folded = {
                --         bg = c.bg,
                --         fg = c.fg,
                --     }
                -- end
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
            vim.opt.list = true
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
            }
        end
    },
    { "lukas-reineke/virt-column.nvim",
        config = function()
            require("virt-column").setup({
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
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
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        -- event = { "InsertEnter" },
        dependencies = { "kevinhwang91/promise-async" },
        -- opts = {
        --     preview = {
        --         mappings = {
        --             scrollB = "<C-b>",
        --             scrollF = "<C-f>",
        --             scrollU = "<C-u>",
        --             scrollD = "<C-d>",
        --         },
        --     },
        --     provider_selector = function(_, filetype, buftype)
        --         local function handleFallbackException(bufnr, err, providerName)
        --             if type(err) == "string" and err:match "UfoFallbackException" then
        --                 return require("ufo").getFolds(bufnr, providerName)
        --             else
        --                 return require("promise").reject(err)
        --             end
        --         end
        --
        --         return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
        --             or function(bufnr)
        --                 return require("ufo")
        --                     .getFolds(bufnr, "lsp")
        --                     :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
        --                     :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
        --             end
        --     end,
        -- },
        --
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
        end
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                relculright = true,
                segments = {
                    {
                        text = { " ", builtin.foldfunc, " " },
                        condition = { builtin.not_empty, true, builtin.not_empty },
                        click = "v:lua.ScFa"
                    },
                    {
                        sign = {
                            name = { "Diagnostic*" },
                            condition = { builtin.not_empty },
                        },
                        click = "v.lua.ScSa"
                    },
                    { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                    {
                        sign = {
                            name = { "GitSign*" },
                            condition = { builtin.not_empty },
                        },
                        click = "v.lua.ScSa"
                    },
                }
            })
        end,
    }
}
