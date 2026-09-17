-- Konfigurera C/C++ språkservern (Clangd)
vim.lsp.config("clangd", {})

-- Starta och aktivera clangd automatiskt för C/C++ filer
vim.lsp.enable("clangd")

-- Kortkommandon (Aktiva bara när du kodar C/C++)
local bufnr = vim.api.nvim_get_current_buf()
local opts = { buffer = bufnr, remap = false }

opts.desc = "Gå till definition"
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

opts.desc = "Visa dokumentation"
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

opts.desc = "Byt namn på variabel"
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

