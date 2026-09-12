return {
  -- [Färgtema]
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme industry]])
    end,
  },

  -- [Git integration]
  { "tpope/vim-fugitive" },

  -- [Filträd / Explorer]
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- Detta tvingar trädet att uppdateras och rita om sig så fort du kör :cd
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
    },
  },

  -- [Debugging - Grunden]
  { "mfussenegger/nvim-dap" },

  -- [LSP-hantering]
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        -- Vi lägger till "codelldb" i Mason för att kunna debugga Rust
        ensure_installed = { "rust_analyzer" }
      })
    end
  },

  -- [Autokomplettering] (Hålls intakt från din förra kod)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  },
  -- The core Debug Adapter Protocol (DAP) client for Neovim
  {
    "mfussenegger/nvim-dap",
  },

  -- A beautiful UI for debugging (variables, call stack, breakpoints, etc.)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      
      -- Automatically open/close the visual layout when debugging starts/ends
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end
  },
  -- [Fuzzy Finder / Sökverktyg]
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8", -- Använd den stabila versionen
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      
      -- 1. Sök efter filnamn (prefix, suffix, vad som helst)
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Sök filer (Filnamn)" })
      
      -- 2. Sök efter text inuti filer (Live Grep)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Sök text inuti filer" })
      
      -- 3. Sök bland dina öppna buffertar
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Sök bland öppna buffertar" })
    end
  }

}

