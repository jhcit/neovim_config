-- 1. Starta och konfigurera lazy.nvim direkt i denna fil
require("lazy").setup({
  -- Här lägger vi till inställningen som fixar ditt hererocks/luarocks-fel!
  rocks = {
    enabled = false, 
  },

  -- 2. Här klistrar du in alla dina plugins i "spec"-blocket
  spec = {
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
          ensure_installed = { "rust_analyzer", "pyright", "clangd"  }
        })
      end
    },

    -- [Autokomplettering]
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

    -- [Debugging - UI]
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
      end
    },

    -- [Fuzzy Finder / Sökverktyg]
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Sök filer (Filnamn)" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Sök text inuti filer" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Sök bland öppna buffertar" })
      end
    }
  }
})

