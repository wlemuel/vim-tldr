" Vim syntax file
" =============================================================================
" File:          syntax/tldr.vim
" Description:   syntax file for tldr
" Author:        Steve Lemuel <wlemuel@hotmail.com>
" Version:       0.3
" =============================================================================

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim

syn match tldrTitle '^# .*$' contains=tldrSymbols
syn match tldrIntro '^> .*$' contains=tldrSymbols
syn match tldrDescr '^- .*$' contains=tldrSymbols
syn match tldrCode  '^`.*`$' contains=tldrKeyword,tldrArgs,tldrSymbols

syn match tldrKeyword '^`\w\+' contained contains=tldrKwSymbl
syn match tldrKwSymbl '^`' contained
syn match tldrArgs  '-\w\+' contained

syn match tldrSymbols '^[#>-] ' contained
syn match tldrSymbols '`$' contained

hi def link tldrTitle Underlined
hi def link tldrIntro Constant
hi def link tldrDescr Statement
hi def link tldrCode Function
hi def link tldrArgs Typedef
hi def link tldrSymbols Ignore
hi def link tldrKeyword Todo
hi def link tldrKwSymbl Ignore

let b:current_syntax = "tldr"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:
