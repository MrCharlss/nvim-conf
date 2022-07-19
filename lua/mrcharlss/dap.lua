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

dap.adapters.node2 = {
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
    outFiles= "${workspaceFolder}/lib/**/*.js",
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}
require("nvim-dap-virtual-text").setup()

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
require('dap.ext.vscode').load_launchjs(nil,{node2 = {'javascript', 'typescript'}})
print(vim.inspect(dap.configurations))
