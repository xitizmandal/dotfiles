return {
    { 'tmux-plugins/vim-tmux-focus-events' },
    { 'christoomey/vim-tmux-navigator' },
    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "[U]ndo Tree" }
        }
    },
    {
        'phaazon/hop.nvim',
        config = function()
            require("hop").setup({})
        end,
        keys = {
            { "F", "<cmd>lua require'hop'.hint_char1()<cr>", noremap = true, silent = true, desc = "Hop" }
        }
    },

    { "nvim-neo-tree/neo-tree.nvim",
        version = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                's1n7ax/nvim-window-picker',
                version = "v1.*",
                config = function()
                    require 'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal', "quickfix" },
                            },
                        },
                        -- other_win_hl_color = '#e35e4f',
                    })
                end,
            }
        },

        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                default_component_configs = {
                    name = {
                        use_git_status_colors = false,
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted   = "✖", -- this can only be used in the git_status source
                            renamed   = "", -- this can only be used in the git_status source
                            -- Status type
                            untracked = "",
                            ignored   = "",
                            unstaged  = "",
                            staged    = "",
                            conflict  = "",
                        }
                    },
                },
                window = {
                    position = "left",
                    -- width = 40,
                },
                filesystem = {
                    filtered_items = {
                        never_show = { "__pycache__" },
                    },
                },
            })
            -- vim.api.nvim_set_keymap('n', '<leader>nt', ":NeoTreeRevealToggle<CR>",
            --    { desc = "[N]eo [T]ree", noremap = true })
        end,
        keys = {
            { '<leader>nt', ":Neotree toggle<cr>", silent = true, desc = "[N]eotree [T]oggle" },
            { '<leader>nf', ":Neotree focus<cr>",  silent = true, desc = "[N]eotree [F]ocus" }
        }

    },
    {
        'nvim-telescope/telescope.nvim', version = false,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                config = function()
                    require('telescope').load_extension('fzf')
                end
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                config = function()
                    require('telescope').load_extension('file_browser')
                end
            },
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--hidden',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--glob',
                        '!**/{.git,__pycache__,node_modules,vendor}/*'
                    },
                    mappings = {
                        n = {
                            ["jk"] = actions.close
                        },
                    },
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.75,
                        preview_cutoff = 120,
                        prompt_position = "top",
                        -- preview_width = 0.5,
                    },
                    -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                    color_devicons = true,

                    winblend = 0,
                    sorting_strategy = "ascending",
                    -- preview = false,
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    file_browser = {
                        layout_strategy = "vertical",
                        hijack_netrw = false,
                    },
                },
                pickers = {
                    find_files = {
                        file_ignore_patterns = { "__pycache__", "node_modules" },
                    }
                }
            })
            -- require('telescope').load_extension('dap')

            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]uzzy [F]files' })
            vim.keymap.set('n', '<leader>fc', builtin.git_files, { desc = '[F]uzzy [C]' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]uzzy [B]uffers' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]uzzy [G]rep' })
            vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[F]uzzy [S]tring' })
            vim.keymap.set('n', '<leader>ft', require("telescope").extensions.file_browser.file_browser,
                { desc = '[F]uzzy [T]ree' })

            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require('telescope.builtin').grep_string(require('telescope.themes').get_ivy {
                    -- winblend = 90,
                    -- previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer]' })
        end
    },

}
