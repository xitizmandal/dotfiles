return {
    { 'tpope/vim-fugitive', },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    vim.keymap.set('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, buffer = bufnr, desc = "Next [C]ommit" })

                    vim.keymap.set('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, buffer = bufnr, desc = "Previous [C]ommit" })
                    vim.keymap.set({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>',
                        { buffer = bufnr, desc = "[H]unk [S]tage" })
                    vim.keymap.set({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>',
                        { buffer = bufnr, desc = "[H]unk [R]eset" })

                    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk,
                        { buffer = bufnr, desc = "[H]unk [U]ndo stage" })
                    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { buffer = bufnr, desc = "[H]unk [S]tage" })
                    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = bufnr, desc = "[H]unk [R]eset Buffer" })
                    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = "[H]unk [P]review" })
                    vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end,
                        { buffer = bufnr, desc = "[H]unk [B]lame" })
                    vim.keymap.set('n', '<leader>htb', gs.toggle_current_line_blame,
                        { buffer = bufnr, desc = "[H]unk [T]oggle [B]lame" })
                    vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = "[H]unk [D]iff" })
                    vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end,
                        { buffer = bufnr, desc = "[H]unk [D]iff ~" })
                    vim.keymap.set('n', '<leader>htd', gs.stage_buffer,
                        { buffer = bufnr, desc = "[H]unk [T]oggle [D]eleted" })
                end
            })
        end

    },
    {
        'junegunn/gv.vim',
        dependencies = { 'tpope/vim-fugitive' },
    },
    {
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
    },
}
