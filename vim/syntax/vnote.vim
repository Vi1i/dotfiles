" Vim syntax file
" Language: Vili Note Taking
" Maintainer: Vili Petal
" Latest Revision: 01 April 2020
if exists("b:current_syntax")
    finish
endif
syntax keyword vnoteTodos TODO XXX FIXME NOTE
syntax region vnoteStrikeout start=/~~/ end=/~~/

highlight default link vnoteTodos Todo
highlight default link vnoteStrikeout Conceal 
