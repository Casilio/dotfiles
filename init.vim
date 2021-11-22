set ignorecase
set iskeyword+=^/
set scrolloff=5
set spell

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

set undodir=~/.vimdir
set undofile

set mouse=

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

let g:fzf_layout = { 'down': '40%' }
let g:fzf_history_dir = '~/.local/share/fzf-history'

set signcolumn=yes

call plug#begin('~/.vim/plugged')
  Plug 'nanotech/jellybeans.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'vim-airline/vim-airline'

  Plug 'tpope/vim-fugitive'
  Plug 'unblevable/quick-scope'
  Plug 'joshdick/onedark.vim'
  Plug 'ap/vim-css-color'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
call plug#end()

" autocmd vimenter * colorscheme jellybeans
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
colorscheme onedark

let mapleader=' '

nmap <leader>gs :G<CR>
nmap <leader>gb :Git blame<CR>
command! Gcommit Git commit

nmap <leader>ff :Files<CR>
nmap <leader>fb :Buffers<CR>
nmap <leader>fl :Lines<CR>
nmap <leader>fa :Rg<CR>

nmap <leader>cr :CocRestart<CR>

" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fa <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:20%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', 'Ctrl-/'),
  \   <bang>0)

vmap <c-f> "hy:Rg<Cr><M-r>h

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

map <ScrollWheelUp> <C-Y>
map <S-ScrollWheelUp> <C-U>
map <ScrollWheelDown> <C-E>
map <S-ScrollWheelDown> <C-D>

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

if has('nvim')
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
  au TermOpen * setlocal nospell
endif
