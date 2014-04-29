set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'ack.vim'
Plugin 'bufexplorer.zip'
Plugin 'xterm16.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'millermedeiros/vim-statline'

call vundle#end()

set autoindent
set backspace=indent,eol,start
set hidden
set number
set pastetoggle=<F4>
set ruler
set spelllang=en_us,nl
set softtabstop=4 shiftwidth=4 expandtab
set smartindent

let g:bufExplorerDefaultHelp = 0
let g:bufExplorerDetailedHelp = 0
let g:bufExplorerFindActive = 0

let g:syntastic_echo_current_error = 1
let g:syntastic_enable_signs = 1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': [] }

nn <f2> :setlocal spell!<cr>
nn <f3> :NERDTreeToggle<cr>
nn <f6> :cclose<cr>

filetype plugin indent on
syntax on

colo xterm16
