function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.config/nvim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
      execute 'source' config_file
    endif
  endfor
endfunction

" Key bindings ----------------------------------------------------------------
let mapleader=' '

" vim-plug ----------------------------------------------------------------
call plug#begin('~/.vim/plugged')
call s:SourceConfigFilesIn('rcplugins')

Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko-m/vim-test'
Plug 'mileszs/ack.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'

" Documentation (Dash on OS X, Zeal on Linux)
if has('mac')
  Plug 'rizzatti/dash.vim'
else
  Plug 'KabbAmine/zeavim.vim'
endif

" Add a file which can be used to try out new plugins without having to commit
" them to the repository.
source ~/.config/nvim/plug-candidates.vim

call plug#end()

" Basic options ---------------------------------------------------------------
syntax on
colorscheme solarized

set autowrite
set nowrap
set ruler
set noswapfile
set nobackup
set relativenumber
set number
set autoindent
set laststatus=2
set backspace=2
set lazyredraw
set inccommand=nosplit
set cursorline

" Always use spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

set isk+=-
set isk+=_
set isk+=$

" Allow local configuration overrides
set exrc
set secure

" How many lines to buffer in a :terminal
set scrollback=100000

" neovim configration --------------------------------------------------------
let g:loaded_python_provider = 1
let g:loaded_python3_provider = 1

" Leader commands -------------------------------------------------------------
nmap <leader>dd :call LookupCursorCommand()<CR>

" Gitting
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit -v

" <c-h> is interpreted as <bs> in neovim
nnoremap <silent> <bs> :TmuxNavigateLeft<cr>

" Test bindings
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Searching
nmap <leader>s :Ack! 

" Zooming
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Rebind exiting insert mode in terminal-mode to <C-o>
tmap <C-o> <C-\><C-n>

" Copy visual content with Enter to the system register
if has('clipboard')
  vnoremap <CR> "+y
endif

" Plugin options --------------------------------------------------------------

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['ruby', 'haskell', 'javascript', 'python', 'bash=sh']

" ctrlp: ignore some folders when indexing
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_user_command = 'rg %s -l --hidden --files'
let g:ctrlp_use_caching = 0

" rg: use `ripgrep` when searching through files
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
  let g:ctrlp_user_command = 'rg %s --files --color=never'
end

if has('mac')
  " dash: set up custom search maps
  let g:dash_map = {
        \ 'scss' : ['sass', 'css', 'bourbon', 'neat'],
        \ }
end

" Functions -------------------------------------------------------------------
function! LookupCursorCommand()
  if has('mac')
    :Dash
  else
    :Zeavim
  endif
endfunction

" Auto commands
autocmd VimResized * :wincmd =
