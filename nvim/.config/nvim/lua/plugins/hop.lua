require('hop').setup {

}
vim.api.nvim_set_keymap('n', 'f',
    "<cmd>lua require'hop'.hint_char1()<cr>"
    , {})
