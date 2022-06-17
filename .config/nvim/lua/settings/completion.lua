--vim.api.nvim_exec([[
--autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
--autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
--" autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global=1
--" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
--" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
--" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
--" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
--" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
--" autocmd BufRead,BufNewFile *.md setlocal spell
--]], true)

local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
    end,
  },
  mapping = {
    -- 
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
--    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--    ['<C-f>'] = cmp.mapping.scroll_docs(4),
--    ['<C-Space>'] = cmp.mapping.complete(),
--    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,

      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'treesitter' },
    { name = 'tags' },
    { name = 'rg' },
  }, {
    { name = 'buffer' },
  }),
})
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
