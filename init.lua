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

