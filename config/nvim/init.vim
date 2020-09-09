call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

colorscheme gruvbox

set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
filetype plugin indent on
syntax on
set spell

let g:rustfmt_autosave = 1

autocmd BufWritePre,InsertLeave * undojoin | Neoformat

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section=''
let g:airline_detect_paste=1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

map <C-n> :NERDTreeToggle<CR>

if has('mouse')
	set mouse=a
endif
