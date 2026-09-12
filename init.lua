-- 1. SÖKVÄG TILL PLUGIN-HANTERAREN (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 2. GRUNDLÄGGANDE EDITEURINSTÄLLNINGAR
require("settings")

-- 3. PLUGINS-KONFIGURATION (Hämtar automatiskt från lua/plugins.lua)
require("lazy").setup("plugins")
require("keymaps")
require("abbreviations")
require("autocmds")
require("settings")

-- ===================================================================
-- TVINGAD DIREKT-DEBUGGER (Klistras in längst ner i din neovim_config/init.lua)
-- ===================================================================
local has_dap, dap = pcall(require, "dap")
if has_dap then
  -- Definiera CodeLLDB-adaptern direkt
  dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
      args = {"--port", "${port}"},
    },
    enrich_config = function(config, on_config)
      config.cwd = vim.fn.getcwd() -- Tvätta bort workspaceRoot direkt i minnet
      on_config(config)
    end,
  }

  -- Skapa en helt fristående startfunktion som ignorerar alla andra plugins
  local function force_start_rust_debug()
    print("Bygger projektet...")
    vim.fn.system("cargo build")

    -- Hitta binärnamnet manuellt
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    local cargo_toml = vim.fn.getcwd() .. '/Cargo.toml'
    if vim.fn.filereadable(cargo_toml) == 1 then
      for line in io.lines(cargo_toml) do
        local name = line:match('^name%s*=%s*"([^"]+)"')
        if name then project_name = name; break end
      end
    end

    -- Starta nvim-dap helt rent
    dap.run({
      name = "Force Launch",
      type = "codelldb",
      request = "launch",
      program = vim.fn.getcwd() .. '/target/debug/' .. project_name,
      cwd = vim.fn.getcwd(),
      stopOnEntry = false,
    })
  end

  -- === NY UNIK GENVÄG FÖR ATT UNDVIKA KROCKAR ===
  -- Använd <leader>dd (Debug Direct) för att starta
  vim.keymap.set('n', '<leader>dd', force_start_rust_debug, { desc = "Debug: Tvinga igång felsökning" })
  
  -- Behåll de vanliga stegen
  vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
  vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = "Debug: Step Next" })
  vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Debug: Step Into" })
  vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = "Debug: Stop/Terminate" })
end

