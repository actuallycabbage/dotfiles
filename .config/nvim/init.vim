" ========================= VIM CONFIG ========================= 
" This config is only tested to be working on Neovim. Your milage may vary in
" regular vim.
"
" Seriously need to clean out this script and remove some bloat.
"
" ========================= NOTES ========================= 
" :noh to clear the highlighting of the last search

let $NVIM_COC_LOG_LEVEL = 'debug'

"pip3 install neovim!

" Install Vim-Plug if it's not.
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Set up vim-markdown-composer
"function! BuildComposer(info)
"  if a:info.status != 'unchanged' || a:info.force
"    if has('nvim')
"      !cargo build --release --locked
"    else
"      !cargo build --release --locked --no-default-features --features json-rpc
"    endif
"  endif
"endfunction

call plug#begin('~/.local/share/nvim/site/plugged')
  Plug 'junegunn/vim-plug'

  """" Minor Misc    
  " Buffer states
  Plug 'zhimsel/vim-stay' 
  " Language pack
  Plug 'sheerun/vim-polyglot' 
  " Sensible set of defaults
  Plug 'tpope/vim-sensible' 
  " Vim Surround
  Plug 'tpope/vim-surround'
  " Tree explorer
  Plug 'preservim/nerdtree'

  """" Visual enhancements
  " Distinguishing between indents.
  Plug 'Yggdroot/indentLine' 
  " Colorscheme
  Plug 'morhetz/gruvbox' 

  " Status line
  "Plug 'bling/vim-airline' 

  " Try the below thing out when neovim 0.5 is released
  "Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
  Plug 'feline-nvim/feline.nvim'
"  Plug 'kyazdani42/nvim-web-devicons' " lua



  """" Language server stuff
  
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  """ Tagbar
  Plug 'preservim/tagbar' " Requires CTags: https://github.com/universal-ctags/ctags
  
  """" Python
  "Plug 'davidhalter/jedi-vim', { 'for': 'python' }
  Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
  Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

  """" Go
  Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }

  """" Markdown
  " Note that this thing also requries you to build some rust stuff. See: https://github.com/euclio/vim-markdown-composer 
  "Plug 'euclio/vim-markdown-composer', { 'for': 'markdown', 'do': function('BuildComposer') } 

  """" Nvim in the browser
  "Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

" Hit :PlugInstall when you make changes
" Also, :PlugUpgrade/:PlugUpdate from time to time 

colorscheme gruvbox

set ruler


""" Set up the LSP Client

"" Lsp Config
lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.gopls.setup{}
EOF
"require'lspconfig'.ccls.setup{on_attach=require'completion'.on_attach}

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <c-space> <C-n>

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect

lua << EOF
  require'compe'.setup({
    enabled = true,
    source = {
      path = true;
      buffer = true;
      nvim_lsp = true;
      spell = true;
      tags = true;
      nvim_treesitter = true;
    };
  })
EOF

"lua require('lua/plugins/status-line.lua')

" Bind jk when in visual / insert modes to <esc>.
" It's closer than hitting <esc>, though I must say it is 2 keys... slow
imap jk <esc>
"vmap jk <esc>

" Sharing same clipboard as OS
set clipboard=unnamed 

" Backspace working as expected.
set backspace=indent,eol,start

" Row numbers
set number 
set relativenumber 
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END


" Old stuff below.

""" Firenvim settings (when using nvim in the browser)
"let fc = g:firenvim_config['localSettings']
"let fc['https://chat.google.com'] = { 'takeover': 'never', 'priority': 1 }
"if exists('g:started_by_firenvim')
"  set background=light
"endif


" GO Stuff
"let g:go_def_mode='gopls'
"let g:go_info_mode='gopls'
"let g:ale_linters = {
"	\ 'go': ['gopls'],
"	\}

"""" Enable Deoplete
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#auto_completion_start_length = 1
"let g:deoplete#sources#jedi#show_docstring = 0 " Docstring in preview window.
"let g:deoplete#sources#jedi#enable_short_types = 1
"" Below is to add omni completion from the faith/vim-go plugin
"call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })


"" Setting up NCM2 (If NCM2 is installed)
" augroup NCM2
"   autocmd!
"   " enable ncm2 for all buffers
"   autocmd BufEnter * call ncm2#enable_for_buffer()
" augroup END 

"""" Autocomplete settings
"set completeopt=noinsert,menuone,noselect
"" Remapping below stops the omnicomplete from auto selecting something
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"" When the <Enter> key is pressed while the popup menu is visible, it only
"" hides the menu. Use this mapping to close the menu and also start a new line.
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")


" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

"""" coc.nvim stuff
" Pretty much just copypasted these from the repo
" set hidden " Don't think I need this?
" set nobackup " Don't think I need this?
" set nowritebackup
" set shortmess+=c
" set updatetime=300


" Avoid showing message extra message when using completion
"set shortmess+=c

"" nvim-completion
" Buffer completion
"let g:completion_chain_complete_list = [
"    \{'complete_items': ['lsp', 'buffers']},
"    \{'mode': '<c-p>'},
"    \{'mode': '<c-n>'}
"\]



"function! ConfigStatusLine()
"  lua require('plugins.status-line')
"endfunction
"
"augroup status_line_init
"  autocmd!
"  autocmd VimEnter * call ConfigStatusLine()
"augroup END

set termguicolors
lua require('feline').setup()
