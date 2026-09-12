local dap = require('dap')

-- 1. Define the GDB Adapter
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" } -- Tells GDB to speak the Debug Adapter Protocol
}

-- 2. Configure Rust to use GDB
dap.configurations.rust = {
  {
    name = "Launch File (GDB)",
    type = "gdb",
    request = "launch",
    program = function()
      -- Automatically prompts you to pick or type the binary path
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}

