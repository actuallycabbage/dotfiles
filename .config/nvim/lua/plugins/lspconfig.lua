-- Good reads
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup{
  settings = {
    Lua = {
      diagnostics = {
         globals = { "vim" }
      },
      runtime = {
         version = "LuaJIT"
      },
      workspace = {
         library = vim.api.nvim_get_runtime_file("", true),
         checkThirdParty = false,
      },
      telemetry = {
         enable = false
      },
    }
  }
}

lspconfig.pyright.setup{
}

-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
lspconfig.gopls.setup{
  settings = {
    gopls = {
      vulncheck = 'Imports', -- this feature is experimental and may be deleted
      usePlaceholders = true,
      staticcheck = true
--      useWorkspaceFolders = true,
--      useSnippets = true,
--      completionSnippets = true,
--      formatting = true,
--      linter = true,
    }
  }
}

lspconfig.terraformls.setup{
}

-- lspconfig.hls.setup{
-- }

return {}
