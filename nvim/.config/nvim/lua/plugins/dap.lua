local dap = require('dap')

local home = vim.fn.getenv("HOME")

dap.adapters.python = {
    type = 'executable';
    command = home .. '/.pyenv/versions/debug/bin/python';
    args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
    {
        -- the first three options are for nvim-dap
        type = 'python';
        request = 'launch';
        name = 'Launch file';

        -- options below are for debugpy
        program = "${file}";
        pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local python_path = os.getenv('VIRTUAL_ENV')
            local conda_path = os.getenv('CONDA_PREFIX')
            if python_path then
                return python_path .. '/bin/python'
            elseif conda_path then
                return conda_path .. '/bin/python'
            end

            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            else
                return 'python'
            end
        end;
    },
}
vim.cmd [[hi! DapBreakpointIcon guisp='#f65866' guifg='#f65866' ctermfg=red]]
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpointIcon', linehl = '', numhl = '' })
vim.api.nvim_set_keymap('n', ',bp', ":DapToggleBreakpoint<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F5>', ":DapContinue<CR>", { noremap = true, silent = true })
