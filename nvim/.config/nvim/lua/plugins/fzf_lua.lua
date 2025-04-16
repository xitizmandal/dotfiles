return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled=true,
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            winopts = {
                row=1,
                height=0.3,
                width=1,
                border="single",
                backdrop=100,
                -- preview={
                --     hidden="hidden"
                -- }
            }

        })

        local fzf = require("fzf-lua")
        vim.keymap.set('n', '<leader>ff', fzf.files, { desc = '[F]uzzy [F]files' })
        vim.keymap.set('n', '<leader>fc', fzf.git_files, { desc = '[F]uzzy [C]' })
        vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = '[F]uzzy [B]uffers' })
        vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = '[F]uzzy [G]rep' })
    end,
}
