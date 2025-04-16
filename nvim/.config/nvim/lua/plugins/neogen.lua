return {
    "danymat/neogen",
    lazy = true,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require('neogen').setup {
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention = "google_docstrings"
                    }
                }
            }
        }
    end,
    keys = {
        { "<leader>ng", "<cmd> lua require('neogen').generate()<cr>",
            { noremap = true, silent = true, desc = "[N]eo [G]enerate" }
        } }
}
