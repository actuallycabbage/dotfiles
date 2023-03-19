-- Good reads
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp
--
--
    -- nvim-cmp
    -- cmp-buffer
    -- cmp-path
    -- cmp_luasnip
    -- cmp-nvim-lsp
    -- LuaSnip
    -- friendly-snippets

local lspconfig = require('lspconfig')
local M = {}

-- 
-- things that can go out
--


-- completion source stuff (nvim-cmp)
M.capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure lspconfig with language servers

-- https://github.com/sumneko/lua-language-server
-- sudo port install lua-language-server
-- lspconfig.sumneko_lua.setup({
--   single_file_support = true,
--   flags = {
--     debounce_text_changes = 150,
--   },
-- })

lspconfig.pyright.setup{
  capabilities = capabilities
}

-- Settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
lspconfig.gopls.setup{
  capabilities = capabilities,
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

-- https://github.com/hashicorp/terraform-ls/releases
lspconfig.terraformls.setup{
  capabilities = capabilities
}

return M
