local dap = require('dap')

local home = vim.fn.getenv("HOME")

dap.adapters.python = {
    type =  'executable';
    command = home .. '/.venvs/debugpy/bin/python';
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

          if python_path then
            return python_path .. '/bin/python'
            end

          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python'
          elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python'
          else
            return '/usr/bin/python'
          end
        end;
    },
}
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

require('dapui').setup()
