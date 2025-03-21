return {
    { 'neovim/nvim-lspconfig' },
    {
        'williamboman/mason.nvim',
        config = function()
            local mason = require("mason")
            mason.setup({
                automatic_installation = false,
                PATH = "append",
                ui = {
                    icons = {
                        server_installed = "✓",
                        server_pending = "➜",
                        server_uninstalled = "✗"
                    }
                }
            })
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            -- "saghen/blink.cmp",
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local border_style = "single"
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

            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, remap = false, silent = true }
                vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set('n', 'gR', function() vim.lsp.buf.references() end, opts)
                vim.keymap.set('n', '<leader>D', function() vim.lsp.buf.type_definition() end, opts)
                vim.keymap.set('n', '<leader>lh', function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set('n', '<leader>la', function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set('v', '<leader>la', function() vim.lsp.buf.range_code_action() end, opts)

                -- diagnostics
                vim.keymap.set('n', '<leader>le', function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set('n', '<leader>lq', function() vim.diagnostic.setqflist() end, opts)
                vim.keymap.set('n', '<leader>ll', function() vim.diagnostic.setloclist() end, opts)
                vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

                -- vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format({ bufnr = bufnr }) end,
                --     opts)
            end



            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            mason_lspconfig.setup({
                ensure_installed = {
                    "pyright",
                    -- "pylsp",
                    "dockerls",
                    "bashls",
                    "yamlls",
                    -- "tsserver",
                    "cssls",
                    "lua_ls",
                    -- "eslint",
                    "rust_analyzer",
                    "html",
                    -- "ruff"
                }
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig["lua_ls"].setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                    },
                                    maxPreload = 10000,
                                },
                            },
                        },
                        on_attach = on_attach,
                        capabilites = capabilities,
                    }
                end,
                ['html'] = function()
                    lspconfig["html"].setup({
                        on_attach = on_attach,
                        filetypes = { "html", "htmldjango" }
                    })
                end,
                ["pyright"] = function()
                    lspconfig["pyright"].setup({
                        on_attach = function(client, bufnr)
                            client.server_capabilities.documentFromattingProvider = false
                            return on_attach(client, bufnr)
                        end
                    })
                end,
                -- ["tsserver"] = function()
                -- end
            })
            -- local util = require('lspconfig.util')
            -- local root_files = {
            --     'pyproject.toml',
            --     'setup.py',
            --     'setup.cfg',
            --     'requirements.txt',
            --     'Pipfile',
            --     'pyrightconfig.json',
            -- }
        end
    },
    -- { "folke/neodev.nvim",    opts = {} }

}
