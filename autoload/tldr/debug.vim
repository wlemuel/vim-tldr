" =============================================================================
" File:          autoload/tldr/debug.vim
" Description:   debug utils for tldr
" Author:        Steve Lemuel <wlemuel@hotmail.com>
" =============================================================================

if exists('g:loaded_tldr_debug') && g:loaded_tldr_debug
    fini
endif

" This is basic vim plugin boilerplate
let s:save_cpo = &cpo
set cpo&vim

fu! tldr#debug#print(message)
    if g:tldr_debug
        echom '[Tldr][debug] - '.a:message
    endif
endf

let g:loaded_tldr_debug = 1

" This is basic vim plugin boilerplate
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set ft=vim et sw=2:
