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
local lsp_defaults = lspconfig.util.default_config

-- Configure default capabilities to announce to LSP servers
lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Diagnostics symbols for display in the sign column.
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

-- completion source stuff (nvim-cmp)
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

lspconfig.tsserver.setup{
  capabilities = capabilities
}

-- -- https://github.com/hashicorp/terraform-ls/releases
-- lspconfig.terraformls.setup{
--   capabilities = capabilities
-- }


lspconfig.clangd.setup{
  capabilities = capabilities
}

