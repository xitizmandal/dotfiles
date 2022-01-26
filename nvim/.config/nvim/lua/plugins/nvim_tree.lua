require'nvim-tree'.setup()

vim.api.nvim_set_keymap('n', '<F3>', ":NvimTreeToggle<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', ":NvimTreeFindFile<CR>", {noremap = true})
