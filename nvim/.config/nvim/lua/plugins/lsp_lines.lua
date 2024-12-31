return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function ()
        require("lsp_lines").setup()
        vim.diagnostic.config({virtual_lines = { only_current_line = true }})
        -- vim.diagnostic.config({virtual_lines = false})
        vim.keymap.set('n', '<leader>tt', require("lsp_lines").toggle, { desc = "Toggle virtual_text" })
    end,
    enabled=false

}
