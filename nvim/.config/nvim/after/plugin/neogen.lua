require('neogen').setup {
    snippet_engine = "luasnip",
    languages = {
        python = {
            template = {
                annotation_convention = "reST"
            }
        }
    }
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>ng", "<cmd> lua require('neogen').generate()<cr>", opts)
