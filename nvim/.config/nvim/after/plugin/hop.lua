require('hop').setup {

}

vim.keymap.set('n', 'f', "<cmd>lua require'hop'.hint_char1()<cr>",  { noremap = true, silent = true  })
