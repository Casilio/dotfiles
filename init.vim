" set paste
" set clipboard=unnamed
" 
set ignorecase
set iskeyword+=^/
set scrolloff=5
set nospell
syntax off

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
  Plug 'vim-airline/vim-airline'

  Plug 'unblevable/quick-scope'
  Plug 'joshdick/onedark.vim'
  Plug 'ap/vim-css-color'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'kdheepak/lazygit.nvim'
  Plug 'stevearc/oil.nvim'
  Plug 'kvrohit/rasmus.nvim'
  Plug 'morhetz/gruvbox'
  Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
call plug#end()

" colorscheme onedark
" colorscheme rasmus
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

let mapleader=' '

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fa <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope resume<cr>
nnoremap <leader>mm <cmd>make<cr>

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

nmap <F5> :Build<cr>
nmap <F6> :Run<cr>

lua << END
require("toggleterm").setup()

require('telescope').setup()

if vim.g.neovide then
  vim.o.guifont = "DM Mono:h15"
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_scroll_animation_length = 0.1

  vim.api.nvim_set_keymap("n", "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end

require("oil").setup()

vim.api.nvim_create_user_command("Ex", "Oil", {})

function buildCommand()
  vim.cmd.cclose()

  if vim.fn.filereadable('./build.bat') ~= 0 then
    return build("build.bat")
  end

  if vim.fn.filereadable('./build.sh') ~= 0 then
    return build("build.sh")
  end

  print("no build file (build.(bat|sh))")
  return 1
end

function runCommand()
  if buildCommand() == 1 then
    return
  end

  if vim.fn.filereadable("./run.bat") ~= 0 then
    return execute("run.bat")
  end

  if vim.fn.filereadable('./run.sh') ~= 0 then
    return execute("run.sh")
  end

  print("no run file (run.(bat|sh))")
  return 0
end

vim.api.nvim_create_user_command('Build', buildCommand, {nargs = 0})
vim.api.nvim_create_user_command('Run', runCommand, {nargs = 0})

vim.api.nvim_create_user_command('BuildDLL',
  function(args)
    vim.cmd.cclose()

    if vim.fn.filereadable('./build_dll.bat') ~= 0 then
      if build("build_dll.bat ") ~= 0 then
        if args.restart then
          vim.fn.system('type nul > restart')
        else
          vim.fn.system('type nul > reload')
        end
      end
      return
    end

    print("no build file (build_dll.(bat|sh))")
  end,
  {nargs = 0, bang = true}
)

function execute(filename)
  local out = vim.fn.systemlist(filename)
  if vim.v.shell_error == 0 then
    return 0
  end

  return 1
end

function build(filename)
  if execute(filename) == 1 then
    return 1
  end

  local files = {}
  for _, file in pairs(out) do
    for f,l,c,e in string.gmatch(file, "(.+)%((%d+):(%d+)%) (.*)") do
      table.insert(
        files, {filename = string.gsub(f, "%/", "\\"), lnum = l, col = c, text = e}
      )
    end
  end

  vim.fn.setqflist(files)
  vim.cmd.copen()

  return 1
end

END
