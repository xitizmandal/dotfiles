return {
    {
        'mfussenegger/nvim-dap',
        lazy=true,
        dependencies = {
            {
                -- FIX: nvim-dap installation fix
                "mxsdev/nvim-dap-vscode-js",
                dependencies = {
                    {
                        "microsoft/vscode-js-debug",
                        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
                    },
                },
                config = function()
                    require("dap-vscode-js").setup({
                        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
                        adapters      = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
                        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
                        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
                        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
                    })
                    local js_based_languages = { "typescript", "javascript", "typescriptreact" }

                    for _, language in ipairs(js_based_languages) do
                        require("dap").configurations[language] = {
                            {
                                type = "pwa-node",
                                request = "launch",
                                name = "Launch file",
                                program = "${file}",
                                cwd = "${workspaceFolder}",
                            },
                            {
                                type = "pwa-node",
                                request = "attach",
                                name = "Attach",
                                processId = require 'dap.utils'.pick_process,
                                cwd = "${workspaceFolder}",
                            },
                            {
                                type = "pwa-chrome",
                                request = "launch",
                                name = "Start Chrome with \"localhost\"",
                                url = "http://localhost:3000",
                                webRoot = "${workspaceFolder}",
                                userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
                            }
                        }
                    end
                end
            },
            {
                'mfussenegger/nvim-dap-python',
                dependencies = 'mfussenegger/nvim-dap',
                config = function()
                    local home = vim.fn.getenv("HOME")
                    local debuggerPath = home .. "/.pyenv/versions/debug/bin/python"
                    require('dap-python').setup(debuggerPath)
                end

            },
            {
                'rcarriga/nvim-dap-ui',
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
        },
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

            require('dap.ext.vscode').load_launchjs()
        end,
        keys = {

            { '<F5>', function() require('dap').continue() end, { desc = "[D]ebugger [C]ontinue" }},
            { '<F6>', function() require('dap').step_over() end, { desc = "[D]ebugger [S]tep Over" }},
            { '<F7>', function() require('dap').step_into() end, { desc = "[D]ebugger Step [I]nto" }},
            { '<F8>', function() require('dap').step_out() end, { desc = "[D]ebugger Step [O]ut" }},
            { '<Leader>dp', function() require('dap').toggle_breakpoint() end, { desc = "[D]ebugger Break [P]oint Toggle" }},
            { '<Leader>ds', function() require('dap').set_breakpoint() end, { desc = "[D]ebugger [S]et Breakpoint" }},
            { '<Leader>dc', function() require('dap').set_breakpoint(vim.fn.input('Condition: '), nil, nil) end, { desc = "[D]ebugger [C]ondition Breakpoint" }},
            { '<Leader>dr', function() require('dap').repl.open() end, { desc = "[D]ebugger [R]epl Open" }},
            { '<Leader>dl', function() require('dap').run_last() end, { desc = "[D]ebugger Run [L]ast" }},
            { '<Leader>dq', function() require('dap').list_breakpoints() end, { desc = "[D]ebugger list breakpoints [Q]" }},
        }
    }
}
