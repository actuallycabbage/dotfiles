-- Good reads
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp

vim.lsp.config("lua_ls", {
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
})

-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
vim.lsp.config("gopls", {
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
})

-- configured by mrcjkb/rustaceanvim
-- vim.lsp.config("rust_analyzer", {
--     settings = {
--         ['rust-analyzer'] = {
--             -- cargo = {
--             --     allFeatures = true
--             -- },
--             checkOnSave = {
--                 command = "clippy"
--             }
--         }
--     }
-- })

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "gopls",
  "terraformls",
  "prismals",
  "clangd",
  "vtsls",
})

return {}
