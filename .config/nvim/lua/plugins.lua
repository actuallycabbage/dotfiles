--ref: https://github.com/wbthomason/dotfiles/blob/main/dot_config/nvim/lua/plugins.lua

--
-- lazy.nvim Bootstrap
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


--
-- lazy.nvim plugin loading
--

require("lazy").setup({

  -- Colorscheme
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "medium" -- hard, soft, medium
      vim.g.gruvbox_material_palette = "original" -- original, mix, material
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_sign_column_background = 'none'
      vim.cmd([[colorscheme gruvbox-material]])
    end
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons" },

  -- API features
  { 'nvim-lua/popup.nvim' },
  { 'nvim-lua/plenary.nvim' },

  -- General
  { 'zhimsel/vim-stay' },     -- Buffer states
  { 'tpope/vim-sensible' },
  { 'tpope/vim-surround' },
  { 'junegunn/vim-easy-align' },
  -- { 'hrsh7th/vim-gindent' },
  {
    'chrisbra/csv.vim',
    ft = "csv",
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = function()
      return require "plugins.gitsigns"
    end
  },
  {
    'numToStr/Comment.nvim',
    opts = function()
      return require "plugins.comment"
    end
  },

  -- { 'folke/todo-comments.nvim', config = lua_path"todo-comments" }

  -- LSP
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require "plugins.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      return require "plugins.lspconfig"
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = function()
      return require "plugins.lspsaga"
    end,
    config = function(_, opts)
      -- require("lspsaga").setup(opts)
      require("lspsaga").setup(opts)
    end,
    dependencies = { {"nvim-tree/nvim-web-devicons"} }
  },

  -- DAP
  {
    'mfussenegger/nvim-dap',
    -- opts = function()
    --   return require "plugins.nvim-dap"
    -- end,
    config = function(_, opts)
      require("dap").adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "js-debug-adapter",
		args = { "${port}" },
	},
      }
      local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact"}
      for _, language in ipairs(js_based_languages) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            -- cwd = "${workspaceFolder}",
	    cwd = vim.fn.getcwd(),

          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = function()
	      return require'dap.utils'.pick_process({filter = 'node'})
	    end,
            -- cwd = "${workspaceFolder}",
	    cwd = vim.fn.getcwd(),
          }
        }
      end
    end,
  },

 --  -- Javascript dap stuff
 --  -- TODO: only attach on typescript / javascript files
 --  {
 --    'mxsdev/nvim-dap-vscode-js',
 --    dependencies = {
	-- 'mfussenegger/nvim-dap'
 --    },
 --    config = function(_, _)
 --      require("dap-vscode-js").setup({
	--  -- Installed by Mason
 --        debugger_cmd = { "js-debug-adapter" },
 --        adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
	-- port = "${port}",
 --      })
	--
 --      local js_based_languages = { "typescript", "javascript", "typescriptreact" }
	--
 --      for _, language in ipairs(js_based_languages) do
	-- print(language);
 --        require("dap").configurations[language] = {
 --          {
 --            type = "pwa-node",
 --            request = "launch",
 --            name = "Launch file",
 --            program = "${file}",
 --            cwd = "${workspaceFolder}",
 --          },
 --          {
 --            type = "pwa-node",
 --            request = "attach",
 --            name = "Attach",
 --            processId = function()
	--       return require'dap.utils'.pick_process({filter = 'node'})
	--     end,
 --            cwd = "${workspaceFolder}",
 --          }
 --        }
 --      end
 --    end,
 --  },


  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --     "nvim-neotest/nvim-nio"
  --   },
  --   opts = function()
  --     return require("plugins.dapui")
  --   end,
  --
  --   config = function(_, opts)
  --     require('dapui').setup(opts)
  --
  --     -- load extensions
  --     -- for _, ext in ipairs(opts.extensions_list) do
  --     --   telescope.load_extension(ext)
  --     -- end
  --   end,
  -- },

  -- -- Go
  -- {
  --   "ray-x/go.nvim",
  --   dependencies = {  -- optional packages
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("go").setup()
  --   end,
  --   event = {"CmdlineEnter"},
  --   ft = {"go", 'gomod'},
  --   build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  -- },

  -- Git
  { 'folke/trouble.nvim' },

  -- Autocomplete
  {
      'hrsh7th/nvim-cmp',
      event = "InsertEnter",
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer'},
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-vsnip' },
        { 'hrsh7th/vim-vsnip' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        { 'onsails/lspkind-nvim' }, -- Adds little pictures to the autocomplete
     },
    opts = function()
      return require "plugins.cmp"
    end,
  },

  -- File Management
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { "NvimTreeToggle", "NvimTreeFocus" , "NvimTreeOpen", "NvimTreeFindFileToggle"},
    opts = function()
      return require "plugins.nvimtree"
    end
  },

  -- Color Renderer
  {
    'NvChad/nvim-colorizer.lua',
    opts = function()
      return require "plugins.colorizer"
    end,
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "plugins.treesitter"
    end,
    config = function(_, opts)
	require('nvim-treesitter.configs').setup(opts)
	vim.api.nvim_create_autocmd({ "BufEnter", "BufNew", "BufWinEnter"  }, {
		group = vim.api.nvim_create_augroup("ts_fold_workaround", { clear = true }),
		callback = function(e)
			-- vim.opt.nofoldenable=true;
			vim.opt.foldmethod="expr";
			vim.opt.foldexpr="nvim_treesitter#foldexpr()";
		end
	})
    end
  },
  -- {
  --   "windwp/nvim-ts-autotag",
  --   config = function (_, opts)
  --     return require("nvim-ts-autotag").setup
  --   end
  -- },

  -- Lines
  {
    'famiu/feline.nvim',
    opts = function()
      return require "plugins.feline"
    end,
  },

  -- Statusline
  {
    "nanozuki/tabby.nvim",
    opts = function()
      return {}
    end,
  },

  -- Misc
  {
    "folke/which-key.nvim",
    keys = {'"', "'", "`" },
    opts = function()
      return require "plugins.whichkey"
    end,
  },

  -- eg: :%Subvert/facilit{y,ies}/building{,s}/g
  -- does fancy search and replaces
  {
    "tpope/vim-abolish"
  },

  -- Telescope
  -- If for some weird reason you're getting the chkstk_darwin issue, find out where fzy-lua-native got installed to and run its makefile
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",

    opts = function()
      return require("plugins.telescope")
    end,

    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- load extensions
      -- for _, ext in ipairs(opts.extensions_list) do
      --   telescope.load_extension(ext)
      -- end
    end,

    dependencies = {
      { 'nvim-telescope/telescope-fzy-native.nvim', run="cd deps/fzy-lua-native && make" },
      { 'cljoly/telescope-repo.nvim' },
      { 'nvim-telescope/telescope-dap.nvim' }
    }
  },

  -- formatting
  {
    "sbdchd/neoformat",
    cmd = {"Neoformat"},
  }

  -- Copilot
  --{ 'github/copilot.vim' } -- run :Copilot setup


})
