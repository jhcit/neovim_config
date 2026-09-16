-- DET NYA SÄTTET: Vi använder Neovims inbyggda API för din rust_analyzer
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
    -- 1. Move your sub-settings (like command) into "check"
        check = {
            command = "clippy",
        },
        -- 2. (Optional) If you want to explicitly enable/disable it, use a boolean
        checkOnSave = true,
    }
  },
})

-- Starta och aktivera rust-analyzer automatiskt för den nuvarande Rust-buffern
vim.lsp.enable("rust_analyzer")

-- Moderna globala LSP-kortkommandon (Aktiva bara när du kodar Rust)
local bufnr = vim.api.nvim_get_current_buf()
local opts = { buffer = bufnr, remap = false }

opts.desc = "Gå till definition"
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

opts.desc = "Visa dokumentation"
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

opts.desc = "Code Action"
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

opts.desc = "Byt namn på variabel"
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

-- ========================================================================== --
-- RUST DEBUGGING (nvim-dap)                                                  --
-- ========================================================================== --
local dap = require('dap')

-- Berätta för Neovim hur den startar debuggaren (codelldb installerad via Mason)
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- Sökvägen till Mason-installationen av codelldb
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = {"--port", "${port}"},
  }
}

-- Konfiguration för hur Rust-projekt ska köras vid debug
dap.configurations.rust = {
  {
    name = "Kör Rust Debugger",
    type = "codelldb",
    request = "launch",
    program = function()
      -- Frågar efter sökväg till din kompilerade binärfil (t.ex. target/debug/mitt_projekt)
      return vim.fn.input('Sökväg till körbar fil (executable): ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceRoot}',
    stopOnEntry = false,
  },
}

-- Kortkommandon för Debugging (Aktiveras bara i Rust-filer)
local bufnr = vim.api.nvim_get_current_buf()
local opts = { buffer = bufnr, remap = false }

opts.desc = "Sätt/Ta bort Breakpoint"
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, opts)

opts.desc = "Starta / Fortsätt Debugging"
vim.keymap.set('n', '<leader>dc', dap.continue, opts)

opts.desc = "Stega Över (Step Over)"
vim.keymap.set('n', '<leader>do', dap.step_over, opts)

opts.desc = "Stega In (Step Into)"
vim.keymap.set('n', '<leader>di', dap.step_into, opts)

-- This file automatically runs ONLY when opening a .rs file
local opts = { buffer = true, silent = true }

vim.keymap.set('n', '<leader>ci', vim.lsp.buf.incoming_calls, opts)
vim.keymap.set('n', '<leader>co', vim.lsp.buf.outgoing_calls, opts)
