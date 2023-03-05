set ignorecase
set iskeyword+=^/
set scrolloff=2

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

" match pairs of <>
set mps+=<:>

set mouse=

set cmdheight=2
set updatetime=300
set shortmess+=c

set signcolumn=yes

set nofoldenable
set wrap

autocmd Filetype go setlocal noexpandtab

let g:netrw_liststyle = 1
let g:netrw_winsize = 30

let g:airline_section_b = ''
let g:airline_powerline_fonts = 1
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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

noremap <leader>tn :tabnew<cr>

call plug#begin('~/.vim/plugged')
  "lsp support for various languages
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  "status bar. not sure i need this
  Plug 'vim-airline/vim-airline'

  Plug 'kdheepak/lazygit.nvim'
  "find a char withing current line
  Plug 'unblevable/quick-scope'
  "inline css colors
  Plug 'ap/vim-css-color'
  "finder
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  " getting a link for remote line
  Plug 'Casilio/link-remote-line'

  "theme
  Plug 'cocopon/iceberg.vim'

  "embedded terminal
  Plug 's1n7ax/nvim-terminal'

  " project management
  Plug 'ahmedkhalf/project.nvim'
call plug#end()

colorscheme iceberg

let mapleader=' '

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nmap <leader>gs :LazyGit<CR>
nmap <leader>gb :Git blame<CR>
command! Gcommit Git commit

nmap <leader>cr :CocRestart<CR>
nmap <leader>cd :CocDiagnostic<CR>

nmap <leader>gl :LinkRemoteLine<CR>

nnoremap <leader>ff <cmd>:Files<cr>
nnoremap <leader>fa <cmd>:Rg<cr>
nnoremap <leader>fb <cmd>:Buffers<cr>
nnoremap <leader>fl <cmd>:Lines<cr>

vmap <c-f> "hy:Rg<Cr><M-r>h

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gi <Plug>(coc-implementation)

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

" scroll floating window
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>

command W w

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

if has('nvim')
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
  au TermOpen * setlocal nospell
endif

lua << EOF
vim.o.hidden = true

require('nvim-terminal').setup({
    window = {
        -- Do `:h :botright` for more information
        -- NOTE: width or height may not be applied in some "pos"
        position = 'botright',

        -- Do `:h split` for more information
        split = 'sp',

        -- Width of the terminal
        width = 50,

        -- Height of the terminal
        height = 15,
    },

    -- keymap to toggle open and close terminal window
    toggle_keymap = '<leader>;',

    terminals = {
        -- keymaps to open nth terminal
        {keymap = '<leader>1'},
        {keymap = '<leader>2'},
        {keymap = '<leader>3'},
        {keymap = '<leader>4'},
        {keymap = '<leader>5'},
    },
})
EOF

" project manager setup
lua << EOF
  require("project_nvim").setup { }
EOF
