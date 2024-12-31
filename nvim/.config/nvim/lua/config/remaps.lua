local opts = {}
vim.keymap.set('i', 'jk', '<esc>', opts)
vim.keymap.set('n', '<up>', '<Nop>', opts)
vim.keymap.set('n', '<down>', '<Nop>', opts)
vim.keymap.set('n', '<left>', '<Nop>', opts)
vim.keymap.set('n', '<right>', '<Nop>', opts)
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
--
-- Deal with wordwrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- quickfix list
vim.keymap.set('n', ']q', ':cnext<CR>', opts)
vim.keymap.set('n', '[q', ':cprev<CR>', opts)
vim.keymap.set('n', '<leader>co', ':copen<cr>', { desc = "qui[c]kfix [o]pen", silent = true })
vim.keymap.set('n', '<leader>cc', ':cclose<cr>', { desc = "qui[c]kfix [c]lose ", silent = true })

-- locallist
vim.keymap.set('n', ']l', ':lnext<CR>', opts)
vim.keymap.set('n', '[l', ':lprev<CR>', opts)
vim.keymap.set('n', '<leader>lo', ':lopen<cr>', { desc = "location[l]ist [o]pen", silent = true })
vim.keymap.set('n', '<leader>lc', ':lclose<cr>', { desc = "location[l]ist [c]lose ", silent = true })

-- buffers
vim.keymap.set('n', ']b', ':bnext<CR>', {})
vim.keymap.set('n', '[b', ':bprev<CR>', {})
