return {
    'stevearc/oil.nvim',
    opts = {
        delete_to_trash = true,
    },
    -- Optional dependencies
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    keys = {
        { '<leader>fv', ":Oil <cr>", silent = true, desc = "[O]il " }
    }

}
