return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            {
                "windwp/nvim-autopairs",
                config = function()
                    require("nvim-autopairs").setup({})
                end,
            },
            { 'windwp/nvim-ts-autotag', }
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all"
                ensure_installed = { "c", "python", "javascript", "typescript", "lua", "rust" },
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                    disable = { "python" }
                },
                incremental_selection = {
                    enable = true,
                },
                autotag = {
                    enable = true
                },
            })
        end

    },
    {
        'numToStr/Comment.nvim',

        config = function()
            require('Comment').setup({})
        end
    },
    {
        "kylechui/nvim-surround",

        version = "*", -- Use for stability; omit to  `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to  defaults
            })
        end
    },
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            local kinds = require("symbols")
            local opts = {
                highlight_hovered_item = false,
                show_guides = true,
                auto_preview = false,
                position = 'right',
                relative_width = true,
                width = 16,
                auto_close = false,
                show_numbers = true,
                show_relative_numbers = true,
                show_symbol_details = false,
                preview_bg_highlight = 'Pmenu',
                autofold_depth = 3,
                auto_unfold_hover = true,
                fold_markers = { kinds["FoldMarkerRight"], kinds["FoldMarkerBottom"] },
                wrap = false,
                keymaps = { -- These keymaps can be a string or a table for multiple keys
                    close = { "<Esc>", "q" },
                    goto_location = "<Cr>",
                    focus_location = "o",
                    hover_symbol = "<C-space>",
                    toggle_preview = "K",
                    rename_symbol = "r",
                    code_actions = "a",
                    fold = "h",
                    unfold = "l",
                    fold_all = "W",
                    unfold_all = "E",
                    fold_reset = "R",
                },
                lsp_blacklist = {},
                symbol_blacklist = {},
                symbols = {
                    File = { icon = kinds["File"], hl = "@text.uri" },
                    Module = { icon = kinds["Module"], hl = "@namespace" },
                    Namespace = { icon = kinds["Namespace"], hl = "@namespace" },
                    Package = { icon = kinds["Package"], hl = "@namespace" },
                    Class = { icon = kinds["Class"], hl = "@type" },
                    Method = { icon = kinds["Method"], hl = "@method" },
                    Property = { icon = kinds["Property"], hl = "@method" },
                    Field = { icon = kinds["Field"], hl = "@field" },
                    Constructor = { icon = kinds["Constructor"], hl = "@constructor" },
                    Enum = { icon = kinds["Enum"], hl = "@type" },
                    Interface = { icon = kinds["Interface"], hl = "@type" },
                    Function = { icon = kinds["Function"], hl = "@function" },
                    Variable = { icon = kinds["Variable"], hl = "@constant" },
                    Constant = { icon = kinds["Constant"], hl = "@constant" },
                    String = { icon = kinds["String"], hl = "@string" },
                    Number = { icon = kinds["Number"], hl = "@number" },
                    Boolean = { icon = kinds["Boolean"], hl = "@boolean" },
                    Array = { icon = kinds["Array"], hl = "@constant" },
                    Object = { icon = kinds["Object"], hl = "@type" },
                    Key = { icon = kinds["Key"], hl = "@type" },
                    Null = { icon = kinds["Null"], hl = "@type" },
                    EnumMember = { icon = kinds["EnumMember"], hl = "@field" },
                    Struct = { icon = kinds["Struct"], hl = "@type" },
                    Event = { icon = kinds["Event"], hl = "@type" },
                    Operator = { icon = kinds["Operator"], hl = "@operator" },
                    TypeParameter = { icon = kinds["TypeParameter"], hl = "@parameter" },
                    Component = { icon = "", hl = "@function" },
                    Fragment = { icon = "", hl = "@constant" },
                },
            }

            require("symbols-outline").setup(opts)
        end,
        keys = {
            { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "[S]ymbols [O]utline" }
        }
    },


    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require('neogen').setup {
                snippet_engine = "luasnip",
                languages = {
                    python = {
                        template = {
                            annotation_convention = "reST"
                        }
                    }
                }
            }

            vim.api.nvim_set_keymap("n", "<leader>ng", "<cmd> lua require('neogen').generate()<cr>",
                { noremap = true, silent = true })
        end,
    },
    {
        "ellisonleao/glow.nvim",
        config = true,
        cmd = "Glow"
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end
    },
}
