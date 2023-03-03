return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require("dap")

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
            vim.keymap.set('n', '<F5>', ":DapContinue<CR>", { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>bp', ":DapToggleBreakpoint<CR>",
                { noremap = true, silent = true, desc = '[B]reak [P]oint' })
        end
    },
    { 'rcarriga/nvim-dap-ui',
        dependencies = 'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dapui.setup({
                layouts = {
                    {
                        elements = {
                            -- Elements can be strings or table with id and size keys.
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                            { id = "scopes",      size = 0.25 },
                        },
                        size = 0.3, -- 40 columns
                        position = "left",
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 0.25, -- 25% of total lines
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = nil, -- These can be integers or a float between 0 and 1. max_width = nil, -- Floats will be treated as percentage of your screen.
                    border = "single", -- Border style. Can be "single", "double" or "rounded"
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                }
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
        end },
}
