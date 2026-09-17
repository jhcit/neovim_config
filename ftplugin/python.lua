-- Konfigurera Python-språkservern (Pyright)
vim.lsp.config("pyright", {})

-- Starta och aktivera pyright automatiskt för Python-filer
vim.lsp.enable("pyright")

-- Kortkommandon (Aktiva bara när du kodar Python)
local bufnr = vim.api.nvim_get_current_buf()
local opts = { buffer = bufnr, remap = false }

opts.desc = "Gå till definition"
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

opts.desc = "Visa dokumentation"
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

opts.desc = "Byt namn på variabel"
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

