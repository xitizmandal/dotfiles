return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        config = function()
            local dap = require("dap")
            local prefix = "/usr/local/"

            dap.defaults.fallback.external_terminal = {
                command = prefix .. '/bin/alacritty',
                args = { '-e' },
            }
            -- local home = vim.fn.getenv("HOME")

            vim.cmd.highlight("DapBreakpointIcon guisp='#e86671' guifg='#e86671' ctermfg=red")
            vim.cmd.highlight("DapStoppedIcon guisp='#98c379' guifg='#98c379' ctermfg=green")
            vim.cmd.highlight("DapStoppedText guibg='#2b6f77' ctermbg=green")
            vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpointIcon', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped',
                { text = '', texthl = 'DapStoppedIcon', linehl = 'DapStoppedText', numhl = '' })

            local home = vim.fn.getenv("HOME")
            local debuggerPath = home .. "/.pyenv/versions/debug/bin/python"

            dap.adapters.python = function(cb, config)
                if config.request == "attach" then
                    local port = (config.connect or config).port
                    local host = (config.connect or config).host or '127.0.0.1'
                    cb({
                        type = "server",
                        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                        host = host,
                        options = {
                            source_filetype = 'python'
                        },
                    })
                else
                    cb({
                        type = 'executable',
                        command = debuggerPath,
                        args = { '-m', 'debugpy.adapter' },
                        options = {
                            source_filetype = 'python',
                        },
                    })
                end
            end

            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = 'launch file',
                    program = "${file}",
                    pythonPath = function()
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. '/venv/vin/python') == 1 then
                            return cwd .. '/venv/bin/python'
                        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                            return cwd .. '/.venv/bin/python'
                        else
                            local cmd = os.getenv("VIRTUAL_ENV") .. '/bin/python'
                            return cmd
                        end
                    end
                }
            }
        end,
        keys = {

            { '<F5>',       function() require('dap').continue() end,                                            { desc = "[D]ebugger [C]ontinue" } },
            { '<F6>',       function() require('dap').step_over() end,                                           { desc = "[D]ebugger [S]tep Over" } },
            { '<F7>',       function() require('dap').step_into() end,                                           { desc = "[D]ebugger Step [I]nto" } },
            { '<F8>',       function() require('dap').step_out() end,                                            { desc = "[D]ebugger Step [O]ut" } },
            { '<Leader>dp', function() require('dap').toggle_breakpoint() end,                                   { desc = "[D]ebugger Break [P]oint Toggle" } },
            { '<Leader>ds', function() require('dap').set_breakpoint() end,                                      { desc = "[D]ebugger [S]et Breakpoint" } },
            { '<Leader>dc', function() require('dap').set_breakpoint(vim.fn.input('Condition: '), nil, nil) end, { desc = "[D]ebugger [C]ondition Breakpoint" } },
            { '<Leader>dr', function() require('dap').repl.open() end,                                           { desc = "[D]ebugger [R]epl Open" } },
            { '<Leader>dl', function() require('dap').run_last() end,                                            { desc = "[D]ebugger Run [L]ast" } },
            { '<Leader>dq', function() require('dap').list_breakpoints() end,                                    { desc = "[D]ebugger list breakpoints [Q]" } },
        }
    },
}
