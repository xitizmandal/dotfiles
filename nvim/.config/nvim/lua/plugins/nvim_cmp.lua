local lspkind = require('lspkind')

lspkind.init({
 symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})

local cmp = require('cmp')
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

vim.g.UltiSnipsRemoveSelectModeMappings = 0

cmp.setup{
    completion = {
        keyword_length = 2
    },
    -- sorting = {},
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    documentation = {
        -- border = 'rounded'
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --   if vim.fn.complete_info()["selected"] == -1 and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        --     vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
        --   elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        --     vim.fn.feedkeys(t("<ESC>:call UltiSnips#JumpForwards()<CR>"))
        --   elseif vim.fn.pumvisible() == 1 then
        --     vim.fn.feedkeys(t("<C-n>"), "n")
        --   elseif check_back_space() then
        --     vim.fn.feedkeys(t("<tab>"), "n")
        --   else
        --     fallback()
        --   end
        -- end, {
        --   "i",
        --   "s",
        -- }),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --   if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        --     return vim.fn.feedkeys(t("<C-R>=UltiSnips#JumpBackwards()<CR>"))
        --   elseif vim.fn.pumvisible() == 1 then
        --     vim.fn.feedkeys(t("<C-p>"), "n")
        --   else
        --     fallback()
        --   end
        -- end, {
        --   "i",
        --   "s",
        -- }),
        -- ["<C-Space>"] = cmp.mapping(function(fallback)
        --   if vim.fn.pumvisible() == 1 then
        --     if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        --       return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
        --     end

        --     vim.fn.feedkeys(t("<C-n>"), "n")
        --   elseif check_back_space() then
        --     vim.fn.feedkeys(t("<cr>"), "n")
        --   else
        --     fallback()
        --   end
        -- end, {
        --   "i",
        --   "s",
        -- }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'path' },
        { name = 'rg' },
        { 
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                    -- local bufs = {}
                    -- for _, win in ipairs(vim.api.nvim_list_wins()) do
                    --     bufs[vim.api.nvim_win_get_buf(win)] = true
                    -- end
                    -- return vim.tbl_keys(bufs)
                end
            }
        },
    },
    formatting = {
        format = function(entry, vim_item)
            -- vim_item.kind = lspkind.presets.default[vim_item.kind]
            vim_item.menu = ({
                nvim_lsp = '[L]',
                buffer = '[B]',
                ultisnips = '[U]',
                rg = '[R]',
            })[entry.source.name]
          return vim_item
        end
    },
}

for index, value in ipairs(vim.lsp.protocol.CompletionItemKind) do
    cmp.lsp.CompletionItemKind[index] = value
end
