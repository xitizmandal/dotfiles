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
            { 'windwp/nvim-ts-autotag', },
            {
                "nvim-treesitter/nvim-treesitter-textobjects"
            }

        },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
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
                },
                incremental_selection = {
                    enable = true,
                    init_selection = "gnn", -- set to `false` to disable one of the mappings
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
                autotag = {
                    enable = true
                },
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of arguments/parameter" },
                            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of arguments/paramter" },
                            ["ab"] = { query = "@block.outer", desc = "Select inner part of arguments/paramter" },
                            ["ib"] = { query = "@block.inner", desc = "Select inner part of arguments/paramter" },

                            ["al"] = { query = "@loop.outer", desc = "Select outer part of conditional" },
                            ["il"] = { query = "@loop.inner", desc = "Select inner part of conditional" },

                            ["af"] = { query = "@function.outer", desc = "Select outer part of function" },
                            ["if"] = { query = "@function.inner", desc = "Select inner part of function" },

                            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = { query = "@function.outer", desc = "Next method/function start" },
                            ["]z"] = { query = "@fold", query_group = "folds", desc = "folds" }
                        },
                        goto_next_end = {
                            ["]F"] = { query = "@function.outer", desc = "Next method/function start" }
                        },
                        goto_previous_start = {
                            ["[f"] = { query = "@function.outer", desc = "Next method/function start" }
                        },
                        goto_previous_end = {
                            ["[F"] = { query = "@function.outer", desc = "Next method/function start" }
                        },
                    },
                }

            })
            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

            -- Repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

            -- vim way: ; goes to the direction you were moving.
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
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
        lazy = true,
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
        end,
        keys = {
            { "<leader>ng", "<cmd> lua require('neogen').generate()<cr>",
                { noremap = true, silent = true, desc = "[N]eo [G]enerate" }
            } }
    },
    {
        "ellisonleao/glow.nvim",
        lazy = true,
        config = true,
        cmd = "Glow"
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    }
}
