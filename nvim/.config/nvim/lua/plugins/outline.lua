return {
    "hedyhli/outline.nvim",
    config = function()
        -- Example mapping to toggle outline
        vim.keymap.set("n", "<leader>so", "<cmd>Outline<CR>",
            { desc = "Toggle Outline" })

        require("outline").setup {
            -- Your setup opts here (leave empty to use defaults)
            outline_window = {
                width = 40,
                relative_width = false,
                show_numbers=true,
                show_relative_numbers=true
            }
        }
    end,
}
