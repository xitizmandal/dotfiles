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
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end



-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = false,
--   }
-- )


--- diagnostic signs
-- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

-- for type, icon in pairs(signs) do
--   local hl = "LspDiagnosticsSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end


vim.lsp.handlers["textDocument/publishDiagnostics"] = 
    function(_, _, params, client_id, _)
        local config = {
            underline = true,
            virtual_text = false,
            -- virtual_text = {
            --     prefix = "> ",
            --     spacing = 4,
            -- },
            signs = true,
            update_in_insert = false,
        }
        local uri = params.uri
        local bufnr = vim.uri_to_bufnr(uri)

        if not bufnr then
            return
        end

        local diagnostics = params.diagnostics

        for i, v in ipairs(diagnostics) do
            diagnostics[i].message = string.format("%s: %s", v.source, v.message)
        end

        vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)
        
        if not vim.api.nvim_buf_is_loaded(bufnr) then
            return
        end

        vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
    end


-- local servers = {'pylsp'}
-- for _, lsp in ipairs(servers) do
--     nvim_lsp[lsp].setup {
--         on_attach =on_attach,
--         capabilities = capabilities,
--     }
-- end

-- nvim-cmp supports addditional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local home = vim.fn.getenv("HOME")

nvim_lsp.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    enable = true,
    cmd = { home .. "/.venvs/nvim/bin/pylsp"},
    settings = {
        -- formatCommand = {"black"},
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
    },
}

-- --- JS/Typescript server
nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- --- C Server
nvim_lsp.ccls.setup{}
