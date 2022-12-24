local actions = require("telescope.actions")
require("telescope").setup({
    defaults = require('telescope.themes').get_ivy({
        mappings = {
            n = {
                ["jk"] = actions.close
            },
        },
        -- layout_strategy = "horizontal",
        -- layout_config = {
        --     width = 0.75,
        --     preview_cutoff = 120,
        --     prompt_position = "bottom",
        -- },

        color_devicons = true,
    })
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]uzzy [F]files' })
vim.keymap.set('n', '<leader>fc', builtin.git_files, { desc = '[F]uzzy [C]' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]uzzy [B]uffers' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]uzzy [G]rep' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[F]uzzy [S]tring' })

vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').grep_string(require('telescope.themes').get_ivy {
        -- winblend = 90,
        -- previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })
