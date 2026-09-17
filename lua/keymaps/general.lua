-- Sidofälten (NvimTree & BufExplorer)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggla Filträd" })

-- Ladda om alla dina inställningar och kortkommandon utan att starta om Neovim
vim.keymap.set('n', '<leader>sv', function()
  -- Rensa Luas minne (cache) för dina egna moduler så de kan laddas om
  for name, _ in pairs(package.loaded) do
    if name:match("^settings") or name:match("^keymaps") then
      package.loaded[name] = nil
    end
  end
  
  -- Kör din init.lua på nytt i bakgrunden
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  print("Konfigurationen har laddats om!")
end, { desc = "Ladda om hela Neovim-konfigurationen" })

-- Exit terminal mode by pressing Escape twice
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode with double Esc' })
vim.keymap.set('n', '<leader>l', '<cmd>set number!<CR>', { desc = 'Toggle line numbers' })

-- Automatically back up yanks and deletes to 'y' and 'd' registers
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("RegisterBackup", { clear = true }),
  callback = function()
    -- Get details about the operation that just happened
    local event = vim.v.event
    local operator = event.operator
    local regcontents = event.regcontents
    local regtype = event.regtype

    -- If the user performed a YANK operation (y)
    if operator == "y" then
      vim.fn.setreg("y", regcontents, regtype)
    
    -- If the user performed a DELETE or CHANGE operation (d, c, x, s, etc.)
    elseif operator == "d" or operator == "c" then
      vim.fn.setreg("d", regcontents, regtype)
    end
  end,
})

-- Paste from 'y' and sync to default + system clipboards
vim.keymap.set({"n", "v"}, "<leader>py", function()
  local text = vim.fn.getreg('y')
  local regtype = vim.fn.getregtype('y')
  
  -- Sync to ALL clipboard registers
  vim.fn.setreg('"', text, regtype)
  vim.fn.setreg('+', text, regtype)
  vim.fn.setreg('*', text, regtype)
  
  return 'p'
end, { expr = true, desc = "Paste from 'y' and sync to clipboard" })

-- Paste from 'd' and sync to default + system clipboards
vim.keymap.set({"n", "v"}, "<leader>pd", function()
  local text = vim.fn.getreg('d')
  local regtype = vim.fn.getregtype('d')
  
  -- Sync to ALL clipboard registers
  vim.fn.setreg('"', text, regtype)
  vim.fn.setreg('+', text, regtype)
  vim.fn.setreg('*', text, regtype)
  
  return 'p'
end, { expr = true, desc = "Paste from 'd' and sync to clipboard" })
