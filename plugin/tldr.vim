" =============================================================================
" File:          plugin/tldr.vim
" Description:   tldr client
" Author:        Steve Lemuel <wlemuel@hotmail.com>
" Version:       0.1
" =============================================================================

if exists("g:loaded_tldr") || &cp || v:version < 700
  finish
endif

" This is basic vim plugin boilerplate
let s:save_cpo = &cpo
set cpo&vim

" Get os type
if has("win64") || has("win32") || has("win16")
  let s:os = "win"
elseif has("mac")
  let s:os = "mac"
else
  let s:os = "unix"
endif

" Global Variables {{{

if !exists("g:tldr_directory_path")
  let g:tldr_directory_path = "~/.cache/tldr"
endif

if !exists("g:tldr_saved_zip_path")
  let g:tldr_saved_zip_path = "~/.cache/tldr-source.zip"
endif

if !exists("g:tldr_source_zip_url")
  let g:tldr_source_zip_url = 
        \ "https://github.com/tldr-pages/tldr/archive/master.zip"
endif

if !exists("g:tldr_enabled_categories")
  if s:os == "mac"
    let categories = ["osx"]
  elseif s:os == "win"
    let categories = ["windows"]
  elseif s:os == "unix"
    let categories = ["linux"]
  else
    let categories = []
  endif

  let g:tldr_enabled_categories = add(categories, "common")
endif

" }}}

command! -nargs=0 TldrUpdateDocs call tldr#updatedocs()
command! -nargs=1 -bar -complete=custom,tldr#complete Tldr call tldr#run(<q-args>)

let g:loaded_tldr = 1

" This is basic vim plugin boilerplate
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set ft=vim et sw=2:
