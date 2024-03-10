" set paste
" set clipboard=unnamed
" 
set ignorecase
set iskeyword+=^/
set scrolloff=5
set nospell

set expandtab
set shiftwidth=2
set tabstop=2
set relativenumber
set nu
set cursorline
set cursorcolumn
set splitbelow
set splitright
set list!
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+,trail:º
set clipboard+=unnamedplus

set undodir=~/.vimdir
set undofile

set mouse=a

set cmdheight=2
set updatetime=300
set shortmess+=c

set signcolumn=yes

let g:netrw_liststyle = 1
let g:netrw_winsize = 30

let g:airline_section_b = ''
let g:airline_detect_spell = 0
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }


call plug#begin('~/.vim/plugged')
"  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"  Plug 'junegunn/fzf.vim'

  Plug 'vim-airline/vim-airline'

  Plug 'unblevable/quick-scope'
  Plug 'joshdick/onedark.vim'
  Plug 'ap/vim-css-color'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'kdheepak/lazygit.nvim'
"  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
"  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

colorscheme onedark

let mapleader=' '


nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fa <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <silent> <leader>gg :LazyGit<CR>

nmap <C-Up> :exe "resize +4"<CR>
nmap <C-Down> :exe "resize -4"<CR>
nmap <C-Right> :exe "vertical resize +4"<CR>
nmap <C-Left> :exe "vertical resize -4"<CR>

nnoremap <C-j> <C-w><C-j>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>

nmap <ScrollWheelUp> <C-Y>
nmap <S-ScrollWheelUp> <C-U>
nmap <ScrollWheelDown> <C-E>
nmap <S-ScrollWheelDown> <C-D>

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" if has('nvim')
"   tnoremap <M-[> <Esc>
"   tnoremap <C-v><Esc> <Esc>
"   au TermOpen * setlocal nospell
" endif

lua << END
require('telescope').setup()
END
