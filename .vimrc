call plug#begin()
Plug 'fatih/vim-go'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'Shougo/vimshell.vim'
Plug 'chriskempson/base16-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'drmingdrmer/vim-tabbar'
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
call plug#end()
let g:easytags_async=1
set tabstop=4 shiftwidth=4 expandtab
set colorcolumn=80
noremap ;; :%s:::g<Left><Left><Left>
set nu
set tabstop=4
set shiftwidth=4
set wildmode=longest,list,full
set wildmenu
set encoding=utf-8
hi CursorLine term=bold cterm=bold guibg=Grey30
set cursorline
noremap <C-a>				gg<S-v>G
inoremap <C-a>				<Esc>gg<S-v>G
set backspace=indent,eol,start
noremap <S-Tab>				:bnext<CR>
noremap <Tab>				:bprev<CR>
noremap <S-l>			<C-w><Right>
noremap <S-h>			<C-w><Left>
noremap <S-k>				<C-w><Up>
noremap <S-j>			<C-w><Down>
noremap <C-l>			<C-w><Right>
noremap <C-h>			<C-w><Left>
noremap <C-k>				<C-w><Up>
noremap <C-j>			<C-w><Down>
noremap T		J
inoremap <C-s>	<Esc>:w<CR> "marche pas
noremap <C-s>	:w<CR>
noremap <C-q>	:qa<CR>
vnoremap <Tab>				>	
vnoremap <S-Tab>			<	
noremap ,ev :sp ~/.vimrc<CR>
noremap ,sv :!source ~/.vimrc<CR>
syntax on
set hidden                              " Can now quit a buffer without saving it
set smartindent
set autoindent
set wildmenu
set wildmode=list:longest
"nnoremap <space> za
nnoremap <space> viw                    " Select word
inoremap <c-d> <esc>ddi
nnoremap <c-u> viwU
inoremap <c-u> <esc>viwUi                       " Uppercase a word
let mapleader = ","
nnoremap <leader>ev :sp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"nnoremap <tab> :tabnext <cr>:tabnext <cr>
"nnoremap <S-tab> :tabprevious <cr>:tabprevious <cr>
nnoremap <F5> :tabprevious <cr>
nnoremap <F6> :tabnext <cr>
nnoremap <F2> :bnext <cr>
" surroundl
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lel
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap <left> <nop>
nnoremap <down> <nop>
nnoremap <up> <nop>
nnoremap <right> <nop>
inoremap <left> <left>
inoremap <down> <down>
inoremap <up> <up>
inoremap <right> <right>
syntax on
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set hlsearch
set incsearch
if filereadable(expand("~/.vim/colors"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
noremap <Tab> :bn<cr>
noremap <S-Tab> :bp<cr>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
set textwidth=80
