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
            -- local home = vim.fn.getenv("HOME")

            vim.cmd.highlight("DapBreakpointIcon guisp='#e86671' guifg='#e86671' ctermfg=red")
            vim.cmd.highlight("DapStoppedIcon guisp='#98c379' guifg='#98c379' ctermfg=green")
            vim.cmd.highlight("DapStoppedText guibg='#2b6f77' ctermbg=green")
            vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpointIcon', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped',
                { text = '', texthl = 'DapStoppedIcon', linehl = 'DapStoppedText', numhl = '' })

            vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "[D]ebugger [C]ontinue" })
            vim.keymap.set('n', '<F6>', function() require('dap').step_over() end, { desc = "[D]ebugger [S]tep Over" })
            vim.keymap.set('n', '<F7>', function() require('dap').step_into() end, { desc = "[D]ebugger Step [I]nto" })
            vim.keymap.set('n', '<F8>', function() require('dap').step_out() end, { desc = "[D]ebugger Step [O]ut" })
            vim.keymap.set('n', '<Leader>dp', function() require('dap').toggle_breakpoint() end,
                { desc = "[D]ebugger Break [P]oint Toggle" })
            vim.keymap.set('n', '<Leader>ds', function() require('dap').set_breakpoint() end,
                { desc = "[D]ebugger [S]et Breakpoint" })
            vim.keymap.set('n', '<Leader>dc', function()
                require('dap').set_breakpoint(vim.fn.input('Condition: '), nil, nil)
            end, { desc = "[D]ebugger [C]ondition Breakpoint" })
            vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end,
                { desc = "[D]ebugger [R]epl Open" })
            vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end,
                { desc = "[D]ebugger Run [L]ast" })
            vim.keymap.set('n', '<Leader>dq', function() require('dap').list_breakpoints() end,
                { desc = "[D]ebugger list breakpoints [Q]" })
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
}
