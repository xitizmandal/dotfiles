return {
    'nvim-telescope/telescope.nvim',
    version = false,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        -- {
        --     'nvim-telescope/telescope-fzf-native.nvim',
        --     build = 'make',
        -- },
        -- { "debugloop/telescope-undo.nvim" }
    },
    enabled=false,
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
                    '!**/{.git,__pycache__,node_modules,vendor, .ccls}/*'
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
            -- extensions = {
            --     fzf = {
            --         fuzzy = true,                   -- false will only do exact matching
            --         override_generic_sorter = true, -- override the generic sorter
            --         override_file_sorter = true,    -- override the file sorter
            --         case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            --         -- the default case_mode is "smart_case"
            --     },
            -- },
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
        -- require('telescope').load_extension('fzf')
        -- require("telescope").load_extension("undo")

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = '[F]uzzy [F]files' })
        vim.keymap.set('n', '<leader>tc', builtin.git_files, { desc = '[F]uzzy [C]' })
        vim.keymap.set('n', '<leader>tb', builtin.buffers, { desc = '[F]uzzy [B]uffers' })
        vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = '[F]uzzy [G]rep' })
        vim.keymap.set('n', '<leader>ts', builtin.grep_string, { desc = '[F]uzzy [S]tring' })
    end
}
