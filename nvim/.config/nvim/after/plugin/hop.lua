require('hop').setup {

}

vim.keymap.set('n', 'F', "<cmd>lua require'hop'.hint_char1()<cr>",  { noremap = true, silent = true  })
