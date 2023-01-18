-- LSP Key Remaps
local on_attach = function(_, bufnr)

    local opts = { buffer = bufnr, remap = false, silent = true }
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>D', function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set('n', '<leader>lh', function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', '<leader>la', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('v', '<leader>la', function() vim.lsp.buf.range_code_action() end, opts)

    -- diagnostics
    vim.keymap.set('n', '<leader>le', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '<leader>lq', function() vim.diagnostic.setloclist() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, opts)
end



local border_style = "single"
-- Diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
    underline = true,
    virtual_text = {
        enable = true,
        prefix = "",
    },

    float = {
        enable = true,
        style = 'minimal',
        focusable = false,
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

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")



mason.setup({
    automatic_installation = false,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- local lsp = require("lsp-zero")

-- lsp.preset("recommended")

-- lsp.on_attach(on_attach)
mason_lspconfig.setup({
    ensure_installed = {
        "pyright",
        "dockerls",
        "bashls",
        "yamlls",
        "tsserver",
        "cssls",
        "sumneko_lua",
        "eslint",

    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("mason-lspconfig").setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
    ["sumneko_lua"] = function()
        require('lspconfig')["sumneko_lua"].setup {
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

})

local util = require('lspconfig.util')
local root_files = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
}

--mason_lspconfig.setup_handlers {
--	function(server_name) -- default handler (optional)
--		lspconfig[server_name].setup {
--			capabilities = require('cmp_nvim_lsp').default_capabilities(),
--			on_attach = on_attach,
--			flags = {
--				debounce_text_changes = 150
--			}
--		}
--	end,
--	["pyright"] = function()
--		--local opts = require("lspconfig.test").config()
--		local opts = {
--			root_dir = function(fname)
--				a = util.root_pattern(unpack(root_files))(fname)
--				b = vim.fn.getcwd()
--				return a or b
--			end,
--		}
--		lspconfig['pyright'].setup(opts)
--	end,
--}


-- local cmp = require('cmp')
-- local luasnip = require('luasnip')
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- 	['<C-p>'] = cmp.mapping.select_prev_item(),
-- 	['<C-n>'] = cmp.mapping.select_next_item(),
-- 	['<C-d>'] = cmp.mapping.scroll_docs(4),
-- 	['<C-u>'] = cmp.mapping.scroll_docs(-4),
-- 	['<C-Space>'] = cmp.mapping.complete(),
-- 	['<C-e>'] = cmp.mapping.close(),
-- 	['<C-y>'] = cmp.mapping.confirm {
-- 		-- behavior = cmp.ConfirmBehavior.Replace,
-- 		select = false,
-- 	},
-- 	['<Tab>'] = cmp.mapping(function(fallback)
-- 		-- if cmp.visible() then
-- 		--     cmp.select_next_item()
-- 		if luasnip.jumpable() then
-- 			luasnip.expand_or_jump()
-- 		else
-- 			fallback()
-- 		end
-- 	end, { "i", "s" }),
--
-- 	['<S-Tab>'] = cmp.mapping(function(fallback)
-- 		-- if cmp.visible() then
-- 		--     cmp.select_prev_item()
-- 		if luasnip.jumpable(-1) then
-- 			luasnip.jump(-1)
-- 		else
-- 			fallback()
-- 		end
-- 	end, { "i", "s" }),
-- })
--
--
-- lsp.setup_nvim_cmp({
-- 	mapping = cmp_mappings
-- })
-- lsp.setup()
