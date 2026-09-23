local builtin = require('telescope.builtin')

-- 1. Vanlig filnamnssökning
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Sök efter filnamn" })

-- 2. UTÖKAD TEXTSÖKNING: Frågar efter både mapp och filändelse först
vim.keymap.set('n', '<leader>fg', function()
  local folder = vim.fn.input("Sök i mapp (t.ex. src, lämna tom för hela projektet): ")
  local extension = vim.fn.input("Filändelse (t.ex. rs, lua, lämna tom för alla): ")

  local opts = {}
  
  -- Hantera sökmapp
  if folder ~= "" then
    opts.search_dirs = { folder }
  end
  
  -- Hantera filändelse via ripgrep-argument för live_grep_args
  if extension ~= "" then
    opts.additional_args = function()
      return { "-g", "*." .. extension }
    end
  end

  -- Anropa det nya pluginet istället för builtin
  require('telescope').extensions.live_grep_args.live_grep_args(opts)
end, { desc = "Sök text med mapp-, filändelsefilter och REGEX" })

-- 2. Buffer Switcher by Extension / Filter (<leader>ft)
vim.keymap.set('n', '<leader>ft', function()
    vim.ui.input({ prompt = 'Filter buffers by extension/term: ' }, function(input)
        if not input or input == "" then return end
        
        -- Open telescope buffers with the user input preset as the default search text
        require('telescope.builtin').buffers({
            default_text = input,
            -- Optional: If you only want exact extension matches, you can do:
            -- default_text = "%." .. input .. "$" 
        })
    end)
end, { desc = 'Telescope list buffers by extension' })

-- 3. Sök bland öppna buffertar
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Sök öppna buffertar" })

-- 4. Pressing `<leader>p` opens a fuzzy-find popup showing all your active registers and their contents.
vim.keymap.set('n', '<leader>p', '<cmd>Telescope registers<CR>', { desc = 'Paste from register' })

-- Standard navigation (Go to definition/implementation)
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { desc = "Go to Definition" })
vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', { desc = "Go to Implementation" })

-- Callers and Symbols (Fuzzy search using Telescope + FZF)
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { desc = "Find Callers (References)" })
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', { desc = "Fuzzy Find Functions/Symbols" })

-- Utility actions (Built-in LSP)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show Documentation" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename Symbol Everywhere" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP Code Actions" })

