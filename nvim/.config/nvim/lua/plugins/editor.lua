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
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { 'nvim-treesitter/nvim-treesitter-context'}

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
        'hedyhli/outline.nvim',
        config = function()
            local kinds = require("symbols")
            local opts = {
                guides = {
                    enabled = true
                },
                keymaps = {
                    close = { "<Esc>", "q" },
                    code_actions = "a",
                    fold = "h",
                    fold_all = "W",
                    fold_reset = "R",
                    goto_location = "<Cr>",
                    hover_symbol = "<C-space>",
                    peek_location = "o",
                    rename_symbol = "r",
                    toggle_preview = "K",
                    unfold = "l",
                    unfold_all = "E",
                    up_and_jump = '<C-p>',
                    down_and_jump = '<C-n>',
                },
                outline_items = {
                    highlight_hovered_item = false,
                    show_symbol_details = false
                },
                outline_window = {
                    auto_close = false,
                    position = "right",
                    relative_width = true,
                    show_numbers = true,
                    show_relative_numbers = true,
                    width = 8,
                    wrap = false
                },
                preview_window = {
                    auto_preview = false,
                    -- winhl = "Normal:Pmenu"
                },
                provider = {
                    lsp = {
                        blacklist_clients = {}
                    }
                },
                symbol_folding = {
                    auto_unfold_hover = false,
                    autofold_depth = 3,
                    markers = { kinds["FoldMarkerRight"], kinds["FoldMarkerBottom"] },
                },
                symbols = {
                    icons = {
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
                    }
                }
            }

            require("outline").setup(opts)
        end,
        keys = {
            { "<leader>so", "<cmd>Outline<cr>", desc = "[S]ymbols [O]utline" }
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
                            annotation_convention = "numpydoc"
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
        -- lazy = true,
        build = function()
            vim.fn["mkdp#util#install"]()
        end
    },
    {
        'cameron-wags/rainbow_csv.nvim',
        config = function()
            vim.g.disable_rainbow_key_mappings = 1
            vim.g.disable_rainbow_hover = 1
            require('rainbow_csv').setup()
        end,
        ft = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon'
        },
        cmd = {
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim'
        }
    }
}
