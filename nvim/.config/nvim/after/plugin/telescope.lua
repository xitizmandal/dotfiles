local actions = require("telescope.actions")
require("telescope").setup({
    -- defaults = require('telescope.themes').get_ivy({
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
            -- theme = "ivy",
            layout_strategy = "vertical",
            -- layout_config = {
            --     anchor = "SW",
            --     height = 0.3,
            --     width = vim.o.columns,
            --     preview_height = 0,
            -- },
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            -- preview = false,
            -- mappings = {
            --     ["i"] = {
            --         -- your custom insert mode mappings
            --     },
            --     ["n"] = {
            --         -- your custom normal mode mappings
            --     },
            -- },
        },
    },
    pickers = {
        find_files = {
            file_ignore_patterns = {"__pycache__", "node_modules"},
        }
    }
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
-- require('telescope').load_extension('dap')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]uzzy [F]files' })
vim.keymap.set('n', '<leader>fc', builtin.git_files, { desc = '[F]uzzy [C]' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]uzzy [B]uffers' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]uzzy [G]rep' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[F]uzzy [S]tring' })
vim.keymap.set('n', '<leader>ft', require("telescope").extensions.file_browser.file_browser, { desc = '[F]uzzy [T]ree' })

vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').grep_string(require('telescope.themes').get_ivy {
        -- winblend = 90,
        -- previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })
