local dapui = require("dapui")

local dap = require("dap")

dap.adapters.node2 = function(cb, config)
    if config.preLaunchTask then
        vim.fn.system(config.preLaunchTask)
    end
    local adapter = {
        type = 'executable',
        command = 'node',
        args = {
            vim.fn.stdpath("data") .. "/mason/packages/" ..
            'node-debug2-adapter/out/src/nodeDebug.js'
        }
    }
    cb(adapter)
end
dap.adapters.chrome = function(cb)
    local adapter = {
        type = 'executable',
        command = 'node',
        args = {
            vim.fn.stdpath("data") .. "/mason/packages/" ..
            'chrome-debug-adapter/out/src/chromeDebug.js'
        }
    }
    cb(adapter)
end
dap.configurations.typescript = {
    {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${workspaceFolder}/lib/app.js',
        cwd = vim.loop.cwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        outFiles = { "${workspaceFolder}/lib/**/*.js" },
        env = { NODE_ENV = 'localhost' },
    },
    {
        type = "node2",
        request = "attach",
        name = "Attach by Process ID",
        skipFiles = {
            "<node_internals>/**"
        },
        processId = require 'dap.utils'.pick_process,
        port = 9229
    },
}
dap.configurations.javascriptreact = {

    {
        type = "chrome",
        request = "attach",
        name = "Attach to Chrome",
        port = 4321,
        skipFiles = {
            "${workspaceFolder}/node_modules/**/*.js"
        },
        urlFilter = "http://localhost:3000/*",
        webRoot = "${workspaceFolder}",
        sourceMaps = true
    },
}
dap.configurations.typescriptreact = {

    {
        type = "chrome",
        request = "attach",
        name = "Attach to Chrome",
        port = 4321,
        skipFiles = {
            "node_modules/**/*.js"
        },
        urlFilter = "http://localhost:3000/*",
        webRoot = "${workspaceFolder}",
        sourceMaps = true
    },
}
require("nvim-dap-virtual-text").setup()
local dapui_opts = {
        icons = { expanded = "", collapsed = "", circular = "" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        -- Use this to override mappings for specific elements
        element_mappings = {},
        expand_lines = true,
        layouts = {
            {
                elements = {
                    { id = "scopes",      size = 0.33 },
                    { id = "breakpoints", size = 0.17 },
                    { id = "stacks",      size = 0.25 },
                    { id = "watches",     size = 0.25 },
                },
                size = 0.33,
                position = "left",
            },
            {
                elements = {
                    { id = "repl",    size = 0.45 },
                    { id = "console", size = 0.55 },
                },
                size = 0.27,
                position = "bottom",
            },
        },
        controls = {
            enabled = true,
            -- Display controls in this element
            element = "repl",
            icons = {
                pause = "",
                play = "",
                step_into = "",
                step_over = "",
                step_out = "",
                step_back = "",
                run_last = "",
                terminate = "",
            },
        },
        floating = {
            max_height = 0.9,
            max_width = 0.5, -- Floats will be treated as percentage of your screen.
            border = "rounded",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
        render = {
            max_type_length = nil, -- Can be integer or nil.
            max_value_lines = 100, -- Can be integer or nil.
        },
    }
dapui.setup()
-- dap ui
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({ reset = true })
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({ reset = true })
end
