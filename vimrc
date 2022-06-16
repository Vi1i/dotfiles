set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mhinz/vim-signify'
Plugin 'vim-airline/vim-airline'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-scripts/scrollfix'
Plugin 'preservim/nerdtree'
Plugin 'dsimidzija/vim-nerdtree-ignore'
Bundle 'chase/vim-ansible-yaml'
call vundle#end()            " required
filetype plugin indent on    " required
" Optional Settings for Plugins
if &term=~'linux'
	let g:airline_disable_statusline = 1
	let g:webdevicons_enable = 0
	let g:webdevicons_enable_nerdtree = 0
	let g:NERDTreeDirArrowExpandable = ''
	let g:NERDTreeDirArrowCollapsible = ''
elseif &term=~'xterm*'
	let g:webdevicons_enable_airline_statusline = 1
endif

" General Settings
syntax on
set nu
set t_RV=
set tabstop=4
set shiftwidth=4
set expandtab
set directory=$HOME/.vim/swapfiles//

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-h> :NERDTreeFocus<CR>
