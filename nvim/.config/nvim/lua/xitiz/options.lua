local HOME = os.getenv('HOME')

vim.g.python3_host_prog = HOME .. '/.pyenv/versions/nvim/bin/python'

vim.o.hlsearch = true
vim.wo.number = true
vim.wo.relativenumber = true
-- vim.o.mouse = ""
vim.o.breakindent = true
vim.o.undofile = true
-- vim.o.smartcase = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.splitright = true
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'
vim.o.termguicolors = true
vim.o.t_Co = 256
vim.o.cursorline = true
vim.o.wildmenu = true
vim.o.pumheight = 10

vim.o.scrolloff = 4
vim.o.autoread = true
vim.o.signcolumn = 'yes'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.updatetime = 25

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "javascript", "javascriptreact", "json" },
    command = "setl sw=2"
})
