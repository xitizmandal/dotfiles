local nvim_lsp = require('lspconfig')

local  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr,  'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', [[<cmd>lua vim.lsp.buf.formatting()<CR>]], opts)
end

-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

vim.diagnostic.config({
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        severity_sort=true,
})


--- diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- nvim-cmp supports addditional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local home = vim.fn.getenv("HOME")

-- nvim_lsp.pylsp.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     enable = true,
--     cmd = { home .. "/.venvs/nvim/bin/pylsp"},
--     settings = {
--         -- formatCommand = {"black"},
--         pylsp = {
--             configurationSources = {"flake8"},
--             plugins = {
--                 pycodestyle = {enabled = false},
--                 pyflakes = {enabled = false},
--                 flake8 = {enabled = true},
--                 pydocstyle = {enabled = false},
--                 mccabe = {enabled = false},
--                 autopep8 = {enabled = false},
--                 yapf = {enabled = false},
--                 pylsp_mypy = {
--                     enabled = false,
--                     live_mode = false,
--                 },
--                 jedi_completion = {fuzzy = true},
--                 pylsp_black = { enabled = true},
--                 pyls_isort = { enabled = true},
--             },
--         },
--     },
-- }

-- --- JS/Typescript server
-- nvim_lsp.tsserver.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }

-- --- C Server
-- nvim_lsp.ccls.setup{}
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})


-- -- Include the servers you want to have installed by default below
local servers = {
  -- "bashls",
  -- "pylsp",
  -- "vuels",
  -- "yamlls",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end


local enhance_server_opts = {
    ["pylsp"] = function(opts)
        opts.settings = {
            pylsp = {
                configurationSources = {"flake8"},
                plugins = {
                    pycodestyle = {enabled = false},
                    pyflakes = {enabled = false},
                    flake8 = {enabled = true},
                    pydocstyle = {enabled = false},
                    mccabe = {enabled = false},
                    autopep8 = {enabled = false},
                    yapf = {enabled = false},
                    pylsp_mypy = {
                        enabled = false,
                        live_mode = false,
                    },
                    jedi_completion = {fuzzy = true},
                    pylsp_black = { enabled = true},
                    pyls_isort = { enabled = true},
                },
            },
        }
    end,
}


lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end
    if enhance_server_opts[server.name] then
        -- Enhance the default opts with the server-specific ones
        enhance_server_opts[server.name](opts)
    end
    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
