--require("dap-go").setup()
local dapui = require("dapui")

local ok, dap = pcall(require, "dap")
if not ok then return end
-- print(vim.inspect(dap))
local icons = {
    active = false,
    on_config_done = nil,
    breakpoint = {
        text = "",
        texthl = "LspDiagnosticsSignError",
        linehl = "",
        numhl = "",
    },
    breakpoint_rejected = {
        text = "",
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
    },
    stopped = {
        text = "",
        texthl = "LspDiagnosticsSignInformation",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "LspDiagnosticsSignInformation",
    },
}
vim.fn.sign_define("DapBreakpoint", icons.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", icons.breakpoint_rejected)
vim.fn.sign_define("DapStopped", icons.stopped)

dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

dap.adapters.node2 = function(cb, config)
    if config.preLaunchTask then
        vim.fn.system(config.preLaunchTask)
    end
    local adapter = {
        type = 'executable',
        command = 'node',
        args = {
            vim.fn.stdpath("data") .. "/dapinstall/jsnode/" ..
                '/vscode-node-debug2/out/src/nodeDebug.js'
        }
    }
    cb(adapter)
end

-- dap.adapters.node2 = {
--     type = 'executable',
--     command = 'node',
--     args = {
--         vim.fn.stdpath("data") .. "/dapinstall/jsnode/" ..
--             '/vscode-node-debug2/out/src/nodeDebug.js'
--     }
-- }
dap.adapters.chrome = {
    type = 'executable',
    command = 'node',
    args = {
        vim.fn.stdpath("data") .. "/dapinstall/jsnode/" ..
            '/vscode-node-debug2/out/src/nodeDebug.js'
    }
}
dap.adapters.typescript = {
    type = 'executable',
    command = 'node',
    args = {
        vim.fn.stdpath("data") .. "/dapinstall/jsnode/" ..
            '/vscode-node-debug2/out/src/nodeDebug.js'
    }
}
dap.adapters.javascript = {
    type = 'executable',
    command = 'node',
    args = {
        vim.fn.stdpath("data") .. "/dapinstall/jsnode/" ..
            '/vscode-node-debug2/out/src/nodeDebug.js'
    }
}
dap.configurations.typescript = {}
dap.configurations.javascript = {
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
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require 'dap.utils'.pick_process,
    },{
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${workspaceFolder}/index.js',
        cwd = vim.loop.cwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        -- outFiles = { "${workspaceFolder}/lib/**/*.js" },
        -- env = { NODE_ENV = 'localhost' },
    }
}
require("nvim-dap-virtual-text").setup()
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
--   -- Expand lines larger than the window
--   -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
--   -- Layouts define sections of the screen to place windows.
--   -- The position can be "left", "right", "top" or "bottom".
--   -- The size specifies the height/width depending on position. It can be an Int
--   -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
--   -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
--   -- Elements are the elements shown in the layout (in order).
--   -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
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
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
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

require('dap.ext.vscode').load_launchjs(nil, { node2 = { 'javascript', 'typescript' } })
