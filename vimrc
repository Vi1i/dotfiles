set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugin 'scrooloose/syntastic'         " To much, espectially for larger projects
Plugin 'tpope/vim-surround'
Plugin 'Tabular'
Plugin 'airblade/vim-gitgutter'
Plugin 'Yggdroot/indentLine'
Plugin 'mhinz/vim-signify'
Plugin 'vim-airline/vim-airline'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-python/python-syntax'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-scripts/scrollfix'
Plugin 'scrooloose/nerdtree'
Bundle 'dsimidzija/vim-nerdtree-ignore'
Plugin 'majutsushi/tagbar'
Plugin 'ledger/vim-ledger'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_cpp_compiler = 'g++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11'
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width=50

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Ledger
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline
set term=xterm-256color
colorscheme default
syntax enable
set nocompatible
set smartindent
set autoindent
"set cindent
"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start
set nu

highlight ColorColumn ctermfg=white
call matchadd('ColorColumn', '\%81v', 100)
highlight OverLength ctermfg=magenta guibg=#592929
match OverLength /\%82v.\+/


if has ("autocmd")
    filetype plugin on
    filetype indent on
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   CPP Enhanced Highlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
"let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   ScrollFix
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"     let g:scrollfix=100 " means lock cursor at bottom of window
"     let g:scrollfix=0   " means keep cursor at top line of window
"     let g:scrollfix=50  " means middle line of screen
"     let g:scrollfix=66  " means two-third from top of screen
let g:scrollfix=66

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   NerdTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable python highlighting:
let g:python_highlight_all = 1

let g:airline_powerline_fonts = 1

"IndentLine Coloring
let g:indentLine_color_term = 239

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.hs,*.java,*.md
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

let g:Powerline_symbols = 'fancy'

nmap <F3> i<C-R>=strftime("%Y-%m-%dT%H:%M:%S%z")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%dT%H:%M:%S%z")<CR>

nmap <F4> i<C-R>=readfile(glob("~/.vim/templates/NotePad.txt"))<CR><ESC>
imap <F4> <C-R>=readfile(glob("~/.vim/templates/NotePad.txt"))<CR>
