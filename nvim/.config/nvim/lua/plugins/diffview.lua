return {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
        file_panel = {
            win_config = {
                position = "right"
            }
        }
    },

    keys = {
        { '<leader>vo', ":DiffviewOpen<CR>",          desc = 'Diff[V]iew [O]pen' },
        { '<leader>vc', ":DiffviewClose<CR>",         desc = 'Diff[V]iew [C]lose' },
        { '<leader>vh', ":DiffviewFileHistory %<CR>", desc = 'Diff[V]iew File [H]istory' },
    }
}
