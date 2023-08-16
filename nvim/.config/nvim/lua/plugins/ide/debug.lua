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
