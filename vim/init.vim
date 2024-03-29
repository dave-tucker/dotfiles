"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/dave/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/dave/.cache/dein')
  call dein#begin('/home/dave/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/dave/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-go', {'build': 'make'})
  call dein#add('fatih/vim-go')
  call dein#add('scrooloose/nerdtree')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('tpope/vim-fugitive')
  call dein#add('vim-airline/vim-airline')
  call dein#add('w0rp/ale')
  call dein#add('mattn/gist-vim')
  call dein#add('mattn/webapi-vim')
  call dein#add('dracula/vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

filetype off                  " required

" turn on syntax highlighting
syntax on

" turn on line numbering
set number

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" color
let g:dracula_colorterm = 0
color dracula

" python
let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

" golang
filetype plugin indent off
set rtp+=$GOROOT/misc/vim
filetype plugin indent on

" airline
set laststatus=2
let g:airline_powerline_fonts=1

" ale
let &runtimepath.=',~/.vim/bundle/ale'
let g:ale_linters = {
\   'python': ['flake8'],
\}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" gist
let g:gist_clip_command = 'xcopy'

" completion
let g:deoplete#enable_at_startup = 1
