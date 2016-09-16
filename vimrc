set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'Tabular'
Plugin 'airblade/vim-gitgutter'
Plugin 'Yggdroot/indentLine'
Bundle 'git://github.com/bling/vim-airline'
Bundle 'vim-ruby/vim-ruby'


"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin o
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set laststatus=2

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"syntax on
syntax enable
" Turn off vi compatibility
set nocompatible

set smartindent
set autoindent
"set cindent

" load indent file for the current filetype
if has ("autocmd")
    filetype plugin on
    filetype indent on
endif
set cursorline
"let g:solarized_tdermcolors=256
set term=xterm-256color
set background=dark
colorscheme default


set tabstop=4
set expandtab
set shiftwidth=4

set nu

"For C++ std 11 higlighting for syntastic
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

let g:airline_powerline_fonts = 1

"IndentLine Coloring
let g:indentLine_color_term = 239

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
