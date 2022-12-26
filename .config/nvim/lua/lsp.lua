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

-- https://github.com/hashicorp/terraform-ls/releases
lspconfig.terraformls.setup{
  capabilities = capabilities
}


-- Keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})
