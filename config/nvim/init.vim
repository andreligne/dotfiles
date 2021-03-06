filetype plugin indent on
syntax enable

set autoindent
set autowrite
set backspace=2
set cursorline
set expandtab
set exrc
set laststatus=2
set lazyredraw
set modeline
set nobackup
set noswapfile
set nowrap
set number
set relativenumber
set ruler
set secure
set shiftwidth=2
set tabstop=2
set tags=.git/tags
set termguicolors

set rtp+=/usr/local/opt/fzf

let mapleader = "\<Space>"

call plug#begin('~/.vim/plugged')

Plug 'bzf/vim-concentric-sort-motion'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'dense-analysis/ale'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent' | Plug 'christoomey/vim-sort-motion'
Plug 'mattn/emmet-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-mkdir'
Plug 'sukima/vim-javascript-imports' | Plug 'sukima/vim-ember-imports'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'neovim/nvim-lspconfig'

Plug 'jparise/vim-graphql'
Plug 'cespare/vim-toml'

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "ruby", "javascript", "typescript", "css", "scss" },
  ignore_install = {},
  highlight = {
    enable = true,
  },
}
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

let g:ale_linters = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'ruby': ['rubocop'],
      \ 'handlebars': ['embertemplatelint'],
      \ 'rust': ['clippy'],
      \ 'sh': ['shellcheck']
      \ }

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'rust': ['rustfmt'],
      \ 'handlebars': ['prettier']
      \ }

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

if executable('rg')
  set grepprg=rg\ --vimgrep
end

nmap <C-p> :Files<CR>
nmap <leader>gc :Gcommit -v
nmap <leader>gs :Gstatus<CR>
nmap <silent> <leader>f :ALEFix<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>t :TestNearest<CR>

nmap <C-]> <Plug>(coc-definition)

tmap <C-o> <C-\><C-n>

" vim-tmux-runner
" https://github.com/christoomey/dotfiles/blob/ea34518fa4d6a03d26d09998fa4486815a2305c0/vim/rcplugins/tmux-runner
nnoremap <leader>va :VtrAttachToPane<cr>
noremap <C-f> :VtrSendLinesToRunner<cr>
