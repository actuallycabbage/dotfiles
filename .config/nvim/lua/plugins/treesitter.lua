vim.filetype.add({ extension = { fbs = "flatbuffers" } })

-- FlatBuffers is not bundled with nvim-treesitter. Register on TSUpdate because
-- nvim-treesitter reloads its parser registry before installing or updating.
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").flatbuffers = {
      install_info = {
        url = "https://github.com/yuanchenxi95/tree-sitter-flatbuffers",
        -- Match the revision shipped in helix-editor/helix's languages.toml.
        revision = "95e6f9ef101ea97e870bf6eebc0bd1fdfbaf5490",
        queries = "queries",
      },
    }
  end,
})

local parsers = {
  "lua",
  "go",
  "python",
  "terraform",
  "markdown",
  "markdown_inline",
  "javascript",
  "typescript",
  "prisma",
  "lalrpop",
  "flatbuffers",
}

-- Lazy may run :TSUpdate during the same startup; waiting prevents both jobs
-- from writing to nvim-treesitter's fixed parser work directories at once.
require("nvim-treesitter").install(parsers):wait(300000)

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua",
    "go",
    "python",
    "terraform",
    "terraform-vars",
    "markdown",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "prisma",
    "lalrpop",
    "flatbuffers",
  },
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

return {}
