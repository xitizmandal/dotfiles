-- Diagnostics
local border_style = "single"
local icons = require("nvim-web-devicons")
-- local kinds = require("symbols")
-- local signs = {
--     Error = kinds["Error"],
--     Warn = kinds["Warn"],
--     Hint = kinds["Hint"],
--     Info = kinds["Info"],
-- }
-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end
local virtual_text = {
    enable = true,
    -- prefix = "",
    source = "if_many",
}
vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    float = {
        severity_sort = true,
        enable = true,
        style = 'minimal',
        -- focusable = false,
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

M = {}
M.toggle_virtual_text = function()
    -- if this Neovim version supports checking if diagnostics are enabled
    -- then use that for the current state
    -- local enabled = true
    -- if vim.diagnostic.is_disabled then
    --     enabled = not vim.diagnostic.is_disabled()
    -- end
    -- enabled = not enabled
    --
    --
    -- if enabled then
    if vim.diagnostic.config()["virtual_text"] then
        vim.diagnostic.config({ virtual_text = false })
    else
        vim.diagnostic.config({
            virtual_text = virtual_text
        })
    end
    -- end
end

vim.keymap.set('n', '<leader>tt', function() M.toggle_virtual_text() end, { desc = "Toggle virtual_text" })
-- return M
