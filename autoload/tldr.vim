" =============================================================================
" File:          autoload/tldr.vim
" Description:   tldr client
" Author:        Steve Lemuel <wlemuel@hotmail.com>
" Version:       0.1
" =============================================================================

if exists("g:autoloaded_tldr") || &cp || v:version < 700
  finish
endif

" This is basic vim plugin boilerplate
let s:save_cpo = &cpo
set cpo&vim


" Script Variables {{{

let s:commands_list = []
let s:command_abspath = ''

" }}}

fu! s:Print(message)
  echom '[Tldr] ' . a:message
endf

fu! s:CheckUnzip()
  if executable("unzip")
    return 1
  else
    call s:Print("unzip not found. 
          \ Please install and run [TldrUpdateDocs] again.")
    return 0
  endif
endf

fu! s:PrepareCommands()
  if isdirectory(expand(g:tldr_directory_path))
    for subdir in g:tldr_enabled_categories
      let files = globpath(g:tldr_directory_path . '/pages/' . subdir, 
            \ '*.md', 0, 1)
      let s:commands_list += map(files, 'fnamemodify(v:val, ":t:r")')
    endfor
  else
    let s:commands_list = ['init']
  endif
endf

fu! s:GetCmdFilePath(cmd)
  let path = ''
  for subdir in g:tldr_enabled_categories
    let abspath = printf('%s/pages/%s/%s.md',
          \ expand(g:tldr_directory_path), subdir, a:cmd)
    if filereadable(abspath)
      let path = abspath
    endif
  endfor

  return path
endf

fu! tldr#updatedocs()
  if s:CheckUnzip()
    if isdirectory(g:tldr_directory_path)
      silent execute '!rm -rf ' . g:tldr_directory_path
    endif

    call s:Print("start to download tldr zip")
    silent exec '!curl -fLo ' . g:tldr_saved_zip_path . ' --create-dirs '
          \ . g:tldr_source_zip_url
    silent exec '!unzip -o -d ~/.cache/ ' . g:tldr_saved_zip_path
    silent exec '!rm -rf ' . g:tldr_saved_zip_path
    silent exec '!mv ~/.cache/tldr-master ' . g:tldr_directory_path
    call s:Print("Now tldr docs is updated!")
  endif
endf

fu! tldr#complete(ArgLead, CmdLine, CursorPos) abort
  if empty(filter(s:commands_list, 'v:val != "init"'))
    call s:PrepareCommands()
  endif

  return join(s:commands_list, "\n")
endf

fu! tldr#run(cmd)
  if !isdirectory(expand(g:tldr_directory_path))
    call s:Print("This is the first time using. 
          \ Please wait a minute for downloading latest tldr docs...")
    call tldr#updatedocs()
    call s:Print("Done! Please try again.")
  else
    let path = s:GetCmdFilePath(a:cmd)
    if path != ''
      exec 'edit' path
    else
      call s:Print(a:cmd . ' does not exist!')
    endif
  endif
endf

let g:autoloaded_tldr = 1

" This is basic vim plugin boilerplate
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set ft=vim et sw=2:
