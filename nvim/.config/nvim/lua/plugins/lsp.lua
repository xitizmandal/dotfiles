local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

--- Code navigation shortcuts
vim.api.nvim_set_keymap('n','gd'," <cmd>lua vim.lsp.buf.definition()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n','gh',"<cmd>lua vim.lsp.buf.hover()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n','gH',"<cmd>lua vim.lsp.buf.code_action<cr>", {noremap = true})
vim.api.nvim_set_keymap('n','gD',"<cmd>lua vim.lsp.buf.implementation()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n','gs',"<cmd>lua vim.lsp.buf.signature_help()<cr>", {noremap = true})
--- vim.api.nvim_set_keymap('n','1gD',"<cmd>lua vim.lsp.buf.type_definition()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n','gr',"<cmd>lua vim.lsp.buf.references()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n','gR',"<cmd>lua vim.lsp.buf.rename()<cr>", {noremap = true})
-- vim.api.nvim_set_keymap('n','g0',"<cmd>lua vim.lsp.buf.document_symbol()<cr>", {noremap = true})
-- vim.api.nvim_set_keymap('n','gW',"<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", {noremap = true})
-- vim.api.nvim_set_keymap('n','<c-]>', "<cmd>lua vim.lsp.buf.declaration()<cr>", {noremap = true})

vim.api.nvim_set_keymap('n',',lo', "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',ld', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", {noremap = true})

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = false,
--   }
-- )


--- diagnostic signs
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


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


nvim_lsp.pylsp.setup {
    enable = true,
    settings = {
        pylsp = {
            configurationSources = {"flake8"},
            plugins = {
                pycodestyle = {enabled = false},
                flake8 = {enabled = true},
                pylsp_mypy = {
                    enabled = true,
                    live_mode = true
                },
                jedi_completion = {fuzzy = true}
            }
        }
    },
    capabilities = capabilities,
}

--- JS/Typescript server
nvim_lsp.tsserver.setup {
}

--- C Server
nvim_lsp.ccls.setup{}

