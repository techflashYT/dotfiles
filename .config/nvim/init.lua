local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- local shellcheck = require("linters/shellcheck")
--local shellcheck = require('efmls-configs.linters.shellcheck')
--local languages = 
--languages.bash = { shellcheck }

require "lspconfig".efm.setup({
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
	languages = require('efmls-configs.defaults').languages()
    }
})
