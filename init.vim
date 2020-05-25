set ignorecase
set iskeyword+=^/
set scrolloff=5
set noincsearch

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

set expandtab
set shiftwidth=2
set tabstop=2
set relativenumber
set nu
set cursorline

let mapleader=' '

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-fugitive'

" don't know if I need this
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
call plug#end() 

set signcolumn=yes

autocmd vimenter * colorscheme gruvbox


nmap <leader>gs :G<CR>

nnoremap <C-p> :GFiles<CR>

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gi <Plug>(coc-implementation)

nmap <leader>n :set nonumber!<CR>

