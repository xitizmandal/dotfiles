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

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "python" },
    command = "set colorcolumn=88"
})

-- vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave" }, {
--     pattern = { "*" },
--     command = "set colorcolumn=+0"
-- })
--
local border_style = "single"
-- Diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
    underline = true,
    virtual_text = {
        enable = true,
        prefix = "",
    },
    float = {
        enable = true,
        style = 'minimal',
        focusable = false,
        border = border_style,
        header = '',
        -- prefix = '',
        -- source = "always",

        format = function(diagnostic)
            return string.format("[%s]: %s", diagnostic.source, diagnostic.message)
        end,
    },
    signs = true,
    update_in_insert = false,
    severity_sort = true,
})


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
        -- Use a sharp border with `FloatBorder` highlights
        border = border_style
    })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
        -- Use a sharp border with `FloatBorder` highlights
        border = border_style
    })

