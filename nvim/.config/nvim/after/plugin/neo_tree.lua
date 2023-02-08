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
    filesystem = {
        filtered_items = {
            never_show = { "__pycache__" },
        },
    },
})
vim.api.nvim_set_keymap('n', '<leader>nt', ":NeoTreeRevealToggle<CR>", { desc = "[N]eo [T]ree", noremap = true })
