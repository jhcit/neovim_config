local builtin = require('telescope.builtin')

-- 1. Vanlig filnamnssökning
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Sök efter filnamn" })

-- 2. UTÖKAD TEXTSÖKNING: Frågar efter både mapp och filändelse först
vim.keymap.set('n', '<leader>fg', function()
  local folder = vim.fn.input("Sök i mapp (t.ex. src, lämna tom för hela projektet): ")
  local extension = vim.fn.input("Filändelse (t.ex. rs, lua, lämna tom för alla): ")

  local opts = {}
  if folder ~= "" then
    opts.search_dirs = { folder }
  end
  if extension ~= "" then
    opts.glob_pattern = "*." .. extension
  end

  builtin.live_grep(opts)
end, { desc = "Sök text med mapp- och filändelsefilter" })

-- 3. Sök bland öppna buffertar
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Sök öppna buffertar" })

-- 4. Pressing `<leader>p` opens a fuzzy-find popup showing all your active registers and their contents.
vim.keymap.set('n', '<leader>p', '<cmd>Telescope registers<CR>', { desc = 'Paste from register' })

