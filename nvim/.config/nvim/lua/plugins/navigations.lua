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
            { "<leader>j", "<cmd>lua require'hop'.hint_char1()<cr>", noremap = true, silent = true, desc = "Hop" }
        }
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                's1n7ax/nvim-window-picker',
                version = "2.*",
                name = 'window-picker',
                config = function()
                    require('window-picker').setup({
                        hint = 'floating-big-letter',
                        filter_rules = {
                            autoselect_one = true,
                            include_current_win = false,
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify", "outline" },

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
            local highlights = require("neo-tree.ui.highlights")
            local kinds = require("symbols")
            require("neo-tree").setup({
                close_if_last_window = true,
                default_component_configs = {
                    name = {
                        use_git_status_colors = false,
                    },
                    icon = {
                        folder_closed = kinds["FolderClosed"],
                        folder_open = kinds["FolderOpen"],
                        folder_empty = kinds["FolderEmpty"],
                        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                        -- then these will never be used.
                        default = "*",
                        highlight = "NeoTreeFileIcon"
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added     = kinds["GitAdd"],      -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified  = kinds["GitModified"], -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted   = kinds["GitDeleted"],  -- this can only be used in the git_status source
                            renamed   = kinds["GitRenamed"],  -- this can only be used in the git_status source
                            -- Status type
                            untracked = kinds["GitUntracked"],
                            ignored   = kinds["GitIgnored"],
                            unstaged  = kinds["GitUnstaged"],
                            staged    = kinds["GitStaged"],
                            conflict  = kinds["GitConflict"],
                        }
                    },
                },
                window = {
                    position = "right",
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
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('oil').setup()
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        version = false,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
            { "debugloop/telescope-undo.nvim" }
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
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                },
                pickers = {
                    find_files = {

                        -- hidden = true,
                        find_command = { 'rg',
                            '--hidden',
                            '--ignore',
                            '--files',
                            '--glob',
                            '!**/{.git,__pycache__,node_modules,vendor}/*'
                        },
                        -- file_ignore_patterns = { "__pycache__", "node_modules" },
                    }
                }
            })
            require('telescope').load_extension('fzf')
            require("telescope").load_extension("undo")

            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]uzzy [F]files' })
            vim.keymap.set('n', '<leader>fc', builtin.git_files, { desc = '[F]uzzy [C]' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]uzzy [B]uffers' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]uzzy [G]rep' })
            vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[F]uzzy [S]tring' })
        end
    },

}
