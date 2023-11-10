vim.opt.foldmethod = "indent"
local group = vim.api.nvim_create_augroup("PythonLocal", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.py" },
    callback = function()
        vim.wo.colorcolumn = '75,80,88'
    end,
    group = group,
})
