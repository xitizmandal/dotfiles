require 'nvim-tree'.setup({
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_width = 2,
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        -- special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", ".gitignore" },
    },
})

vim.api.nvim_set_keymap('n', '<F3>', ":NvimTreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>o', ":NvimTreeFindFile<CR>", { noremap = true })
