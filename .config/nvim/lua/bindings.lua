-- Insert remap
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true, silent = true })


-- LSP (lspsaga)
vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Lspsaga actions",
  callback = function()
    local keymap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Hover Doc
    -- If there is no hover doc,
    -- there will be a notification stating that
    -- there is no information available.
    -- To disable it just use ":Lspsaga hover_doc ++quiet"
    -- Pressing the key twice will enter the hover window
    -- keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
    -- If you want to keep the hover window in the top right hand corner,
    -- you can pass the ++keep argument
    -- Note that if you use hover with ++keep, pressing this key again will
    -- close the hover window. If you want to jump to the hover window
    -- you should use the wincmd command "<C-w>w"
    keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")
    
    -- LSP finder - Find the symbol's definition
    -- If there is no definition, it will instead be hidden
    -- When you use an action in finder like "open vsplit",
    -- you can use <C-t> to jump back
    keymap("n", "gh", "<cmd>Lspsaga finder<CR>")
    
    -- Code action
    keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    
    -- Go to definition
    keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")
    
    -- Rename all occurrences of the hovered word for the selected files
    keymap("n", "<F2>", "<cmd>Lspsaga rename ++project<CR>")
    
    
    -- Peek type definition
    -- You can edit the file containing the type definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
    
    -- Show line diagnostics
    -- You can pass argument ++unfocus to
    -- unfocus the show_line_diagnostics floating window
    keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
    
    -- Show buffer diagnostics
    keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
    
    -- Show workspace diagnostics
    keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
    
    -- Show cursor diagnostics
    keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
    
    -- Toggle outline
    keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")
    
    -- Call hierarchy
    keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
    
    -- -- Floating terminal
    -- keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
end
})

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,

})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = {"*.ts", "*.js", "*.tsx", "*.jsx"},
--   command 
--   group = format_sync_grp,
-- })

-- easyalign
-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.keymap.set('x', 'ga', '<cmd>EasyAlign<CR>')
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set('n', 'ga', '<cmd>EasyAlign<CR>')

-- telescope maps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fp', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

vim.api.nvim_set_keymap('n', '<leader>ft', '<cmd>NvimTreeFindFileToggle<CR>', { noremap = true })

-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--
