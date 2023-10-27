vim.o.autochdir = false
vim.o.clipboard = 'unnamedplus'
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true

-- Always show tabline
vim.o.showtabline = 2

-- Disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Folding using treesitter
-- vim.opt.foldmethod = "expr"
vim.opt.foldlevel=99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

