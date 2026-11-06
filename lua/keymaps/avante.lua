-- Avante genvägar (Flyttade hit för att garantera att de registreras korrekt)
vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>AvanteAsk<cr>", { desc = "AI Chat/Ask" })
vim.keymap.set("v", "<leader>ae", "<cmd>AvanteEdit<cr>", { desc = "AI Edit" })

