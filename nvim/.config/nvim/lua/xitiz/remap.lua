vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local opts = {}
vim.keymap.set('i', 'jk', '<esc>', opts)
vim.keymap.set('n', '<up>', '<Nop>', opts)
vim.keymap.set('n', '<down>', '<Nop>', opts)
vim.keymap.set('n', '<left>', '<Nop>', opts)
vim.keymap.set('n', '<right>', '<Nop>', opts)
vim.keymap.set('n', '<Space>', '<Nop>', {silent = true})

vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
--
-- Deal with wordwrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

