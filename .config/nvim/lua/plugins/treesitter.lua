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
  },
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

return {}
