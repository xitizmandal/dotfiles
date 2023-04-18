return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require("dap")
            local homebrew_prefix = vim.fn.getenv("HOMEBREW_PREFIX")

            dap.defaults.fallback.external_terminal = {
                command = homebrew_prefix .. '/bin/alacritty',
                args = { '-e' },
            }
            local home = vim.fn.getenv("HOME")

            dap.adapters.python = {
                type = 'executable',
                command = home .. "/.pyenv/versions/debug/bin/python",
                args = { '-m', 'debugpy.adapter' },
            }

            dap.configurations.python = {
                {
                    -- the first three options are for nvim-dap
                    type = 'python',
                    request = 'launch',
                    name = 'Launch file',

                    -- options below are for debugpy
                    program = "${file}",
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
                    end,
                },
            }

            vim.cmd.highlight("DapBreakpointIcon guisp='#f65866' guifg='#f65866' ctermfg=red")
            vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpointIcon', linehl = '', numhl = '' })
            -- vim.keymap.set('n', '<F5>', ":DapContinue<CR>", { noremap = true, silent = true })

            vim.keymap.set('n', '<leader>bp', ":DapToggleBreakpoint<CR>",
                { noremap = true, silent = true, desc = '[B]reak [P]oint' })

            vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
            vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
            vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
            vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)
            vim.keymap.set('n', '<Leader>bp', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<Leader>bs', function() require('dap').set_breakpoint() end)
            vim.keymap.set('n', '<Leader>bc', function()
                require('dap').set_breakpoint(vim.fn.input('Condition: '), nil, nil)
            end)
            vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
            vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
            vim.keymap.set('n', '<Leader>dq', function() require('dap').list_breakpoints() end)
        end
    },
    { 'rcarriga/nvim-dap-ui',
        dependencies = 'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dapui.setup({
            })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    },
}
