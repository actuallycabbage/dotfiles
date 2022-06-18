local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- A lot has been borrowed from https://github.com/crivotz/nv-ide/blob/master/lua/plugins.lua
-- In this file
--
-- Other things worth looking at
-- https://github.com/rafamadriz/dotfiles/blob/b90a6107915db55fba97d161a002e3902a25dd09/private_dot_config/nvim/lua/plugins/init.lua

-- This block will get packer to update all the plugins on buffer write, beware
-- Run PackerSync to download them
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile", 
})

return require('packer').startup(function(use)

  local lua_path = function(name)
    return string.format("require'plugins.%s'", name)
  end

  -- Get packer to keep itself updated
  use { 'wbthomason/packer.nvim' }

  -- Icons
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'ryanoasis/vim-devicons' }

  -- API features
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }

  -- General
  use { 'zhimsel/vim-stay' } -- Buffer states
  use { 'sheerun/vim-polyglot' } -- Extra syntax highlighting
  use { 'tpope/vim-sensible' } -- Sensible set of defaults
  use { 'tpope/vim-surround' } -- Vim Surround
  use { 'numToStr/Comment.nvim', config = lua_path"comment"} 
  use { 'junegunn/vim-easy-align' }
  use { 'chrisbra/csv.vim' }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
}
  
  -- LSP
  use { 'neovim/nvim-lspconfig' }
  use { 'onsails/lspkind-nvim' } -- Adds little logos to the autocomplete
  use { 'fatih/vim-go' }
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }
  use { 'folke/trouble.nvim' }
  -- use { 'folke/todo-comments.nvim', config = lua_path"todo-comments" }
  -- use { 'folke/which-key.nvim', config = lua_path"which-key" }


  -- Autocomplete
  use ({
      'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer'},
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-vsnip' },
        { 'hrsh7th/vim-vsnip' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' }
     }
  })

  -- Explorer
  use { 'kyazdani42/nvim-tree.lua', config = lua_path"nvimtree" }

  -- Colorscheme
  use { 'sainnhe/gruvbox-material' }

  -- Color Renderer
  use { 'crivotz/nvim-colorizer.lua', config = lua_path"colorizer" }
  
  -- Lines
  use { 'famiu/feline.nvim' , config = lua_path"feline" } -- Statusline
  --use { 'romgrk/barbar.nvim' } -- Puts your buffers up in the tab bar
  use {
    "nanozuki/tabby.nvim",
    config = function() require("tabby").setup() end,
  }


  -- Telescope
  -- If for some weird reason you're getting the chkstk_darwin issue, find out where fzy-lua-native got installed to
  -- and run its makefile
  use { 'nvim-telescope/telescope.nvim', config = lua_path"telescope" }
  use { 'nvim-telescope/telescope-fzy-native.nvim', run="make" }
  use { 'cljoly/telescope-repo.nvim' }
  use { 'nvim-telescope/telescope-dap.nvim' }

  -- Copilot
  --use { 'github/copilot.vim' } -- run :Copilot setup

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
