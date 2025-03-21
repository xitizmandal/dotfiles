return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        {
            'saadparwaiz1/cmp_luasnip',
            dependencies = {
                "L3MON4D3/LuaSnip",
            }
        },
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    enabled = true,
    opts = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local border_style = "single"

        return {
            completion = {
                keyword_length = 2
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            window = {
                completion = {
                    border = border_style,
                },
                documentation = {
                    border = border_style,
                }
            },
            mapping = {
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<C-y>'] = cmp.mapping.confirm({ select = false }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
                -- { name = 'rg' },
                {
                    name = 'buffer',
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end
                    }
                },
                { name = 'nvim_lsp_signature_help' },
            },
            formatting = {
                format = function(entry, vim_item)
                    -- Kind icons
                    vim_item.kind = string.format('%s', vim_item.kind)     -- This concatonates the icons with the name of the item kind
                    -- Source
                    vim_item.menu = ({
                        luasnip = "[LuaSnip]",
                        nvim_lsp = "[LSP]",
                        buffer = "[Buffer]",
                        nvim_lua = "[Lua]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end
            },
        }
    end
}
