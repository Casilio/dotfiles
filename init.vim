set ignorecase
set iskeyword+=^/
set scrolloff=5
set spell

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

set expandtab
set shiftwidth=2
set tabstop=2
set relativenumber
set nu
set cursorline
set splitbelow
set splitright
set list!
set list listchars=tab:>-,trail:·

set undodir=~/.vimdir
set undofile

" I'm using fish and it makes fugitive sooooo slow. This is a workaround.
set shell=/bin/bash\ --login

set signcolumn=yes

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

autocmd vimenter * colorscheme gruvbox

let mapleader=' '

nmap <leader>gs :G<CR>

nmap <leader>ff :Files<CR>
nmap <leader>fb :Buffers<CR>
nmap <leader>fl :Lines<CR>
nmap <leader>fa :Ag<CR>

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gi <Plug>(coc-implementation)

nmap <Up> :exe "resize +4"<CR>
nmap <Down> :exe "resize -4"<CR>
nmap <Right> :exe "vertical resize +4"<CR>
nmap <Left> :exe "vertical resize -4"<CR>

nnoremap <C-j> <C-w><C-j>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
