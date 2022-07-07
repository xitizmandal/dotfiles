local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob',
      '!**/{.git,__pycache__,node_modules,vendor}/*'
    },
    mappings = {
        n = {
            ["jk"] = actions.close
        },
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
        width = 0.75,
        preview_cutoff = 120,
        prompt_position = "top",
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {
        "absolute",
    },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
  extensions  = {
      media_files = {
          filetypes = {"png", "jpg", "pdf", "jpeg"},
          find_cmd = "rg"
      }
  },
  -- pickers = {
  --     buffers = {

  --         mappings = {
  --             i = {
  --                 ["<c-d>"] = actions.delete_buffer 
  --             }
  --         }
  --     }
  -- }
}
-- nnoremap ,ff <cmd>lua require'telescope.builtin'.find_files{find_command={'rg' , '--files', '--hidden', '--smart-case', '--glob', '!**/{.git,__pycache__,node_modules,vendor}/*'}}<cr>
-- nnoremap ,fg <cmd>Telescope live_grep<cr>
-- nnoremap ,fb <cmd>Telescope buffers<cr>
-- " nnoremap ,fh <cmd>Telescope help_tags<cr>
-- nnoremap ,fc <cmd>Telescope git_bcommits<cr>
-- nnoremap ,fC <cmd>Telescope git_commits<cr>
-- nnoremap ,fd <cmd>Telescope git_status<cr>

-- " LSP pickers
-- nnoremap ,fl <cmd>Telescope lsp_document_symbols<cr>
-- nnoremap ,ft <cmd>Telescope treesitter<cr>

require('telescope').load_extension('media_files')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('dap')

vim.api.nvim_set_keymap('n', ',ff', "<cmd> lua require('telescope.builtin').find_files{find_command={'rg', '--files', '--hidden', '--smart-case', '--glob', '!**/{.git,__pycache__,node_modules,vendor}/*'}}<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fF', "<cmd> lua require('telescope.builtin').find_files()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fg', "<cmd> lua require('telescope.builtin').live_grep()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fb', "<cmd> lua require('telescope.builtin').buffers()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fc', "<cmd> lua require('telescope.builtin').git_bcommits()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fC', "<cmd> lua require('telescope.builtin').git_commits()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fd', "<cmd> lua require('telescope.builtin').git_status()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fs', "<cmd> lua require('telescope.builtin').lsp_document_symbols()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fl', "<cmd> lua require('telescope.builtin').lsp_document_diagnostics()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fw', "<cmd> lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',ft', "<cmd> lua require('telescope.builtin').treesitter()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fm', "<cmd> lua require('telescope.builtin').marks()<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', ',fj', "<cmd> lua require('telescope.builtin').jumplist()<cr>", {noremap = true})
