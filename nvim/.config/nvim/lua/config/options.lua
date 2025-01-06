local HOME = os.getenv('HOME')

vim.g.python3_host_prog = HOME .. '/.pyenv/versions/nvim/bin/python'

vim.o.hlsearch = true
vim.wo.number = true
vim.wo.relativenumber = true
-- vim.o.mouse = ""
vim.o.breakindent = true
-- vim.o.undofile = true
-- vim.o.smartcase = true

vim.o.swapfile = false
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.splitright = true
vim.o.splitbelow = true
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'
vim.o.termguicolors = true
-- vim.o.t_Co = 256
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

-- vim.o.foldenable = true                                      -- enable fold for nvim-ufo
-- vim.o.foldlevel = 99                                         -- set high foldlevel for nvim-ufo
-- vim.o.foldlevelstart = 99                                    -- start with all code unfolded
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.colorcolumn = '80,120'
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufLeave" }, {
--     pattern = { "*" },
--     callback = function()
--         vim.opt.colorcolumn = '80,120'
--     end,
-- })

vim.o.exrc = true
-- vim.opt.list = true
-- vim.opt.listchars:append {
--     trail="·",
-- eol = "\\u21b5",
-- 26f1
-- }
-- vim.o.statuscolumn = '%=%l%s%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "▼" : "⏵") : " " }'
--
vim.wo.conceallevel = 2
