return {

    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    -- enabled=false,
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',
	enabled=false,

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        keymap = {
            preset = 'default',
            ["<Tab>"] = { "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, via `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'luasnip', 'markdown', 'obsidian', 'obsidian_new', "obsidian_tags" },
            -- optionally disable cmdline completions
            -- cmdline = {},
            providers = {
                lsp = {
                    name = "lsp",
                    enabled = true,
                    module = "blink.cmp.sources.lsp",
                    -- min_keyword_length = 2,
                    -- kind = "LSP",
                    -- When linking markdown notes, I would get snippets and text in the
                    -- suggestions, I want those to show only if there are no LSP
                    -- suggestions
                    fallbacks = { "snippets", "luasnip", "buffer" },
                    score_offset = 90, -- the higher the number, the higher the priority
                },
                luasnip = {
                    name = "luasnip",
                    enabled = true,
                    module = "blink.cmp.sources.luasnip",
                    min_keyword_length = 2,
                    fallbacks = { "snippets" },
                    score_offset = 85, -- the higher the number, the higher the priority
                },
                path = {
                    name = "Path",
                    module = "blink.cmp.sources.path",
                    score_offset = 90,
                    -- When typing a path, I would get snippets and text in the
                    -- suggestions, I want those to show only if there are no path
                    -- suggestions
                    fallbacks = { "snippets", "luasnip", "buffer" },
                    opts = {
                        trailing_slash = false,
                        label_trailing_slash = true,
                        -- get_cwd = function(context)
                        --     return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                        -- end,
                        show_hidden_files_by_default = true,
                    },
                },
                buffer = {
                    name = "Buffer",
                    module = "blink.cmp.sources.buffer",
                    min_keyword_length = 2,
                },
                snippets = {
                    name = "snippets",
                    enabled = true,
                    module = "blink.cmp.sources.snippets",
                    score_offset = 80, -- the higher the number, the higher the priority
                    min_keyword_length = 2,
                },
                -- Example on how to configure dadbod found in the main repo
                -- https://github.com/kristijanhusak/vim-dadbod-completion
                -- dadbod = {
                --     name = "Dadbod",
                --     module = "vim_dadbod_completion.blink",
                --     score_offset = 85, -- the higher the number, the higher the priority
                -- },
                obsidian = {
                    name = "obsidian",
                    module = "blink.compat.source",
                },
                obsidian_new = {
                    name = "obsidian_new",
                    module = "blink.compat.source",
                },
                obsidian_tags = {
                    name = "obsidian_tags",
                    module = "blink.compat.source",
                },
                markdown = { name = 'RenderMarkdown', module = 'render-markdown.integ.blink' },
            },
        },
        -- list = {
        --     selection = "auto_insert",
        -- },
        completion = {
            menu = {
                draw = {
                    padding = { 1, 0 },
                    columns = {
                        { 'label',            gap = 2 },
                        { 'kind_icon',        'kind', gap = 1 },
                        { 'source_name',      gap = 2 },
                        { 'label_description' },
                    },
                    components = {
                        kind_icon = { width = { fill = true } },
                        source_name = {
                            text = function(ctx) return "[" .. tostring(ctx.source_name) .. "]" end
                        }
                    }
                }
            },
            documentation = { auto_show = true, auto_show_delay_ms = 0 }
        },
        snippets = {
            expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
            active = function(filter)
                if filter and filter.direction then
                    return require('luasnip').jumpable(filter.direction)
                end
                return require('luasnip').in_snippet()
            end,
            jump = function(direction) require('luasnip').jump(direction) end,
        },
        -- experimental signature help support
        signature = { enabled = true }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }
}
