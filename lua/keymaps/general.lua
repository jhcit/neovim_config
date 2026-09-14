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

