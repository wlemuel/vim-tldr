" =============================================================================
" File:          autoload/tldr.vim
" Description:   tldr client
" Author:        Steve Lemuel <wlemuel@hotmail.com>
" =============================================================================

if exists("g:autoloaded_tldr") || &cp || v:version < 700
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

" Script Variables {{{

let s:commands_list = []
let s:command_abspath = ''
let s:buffer_name = '__tldr__'
let s:fallback_language_folder = expand(g:tldr_directory_path).'/pages'
let s:language_folder = ''

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
    call s:CheckPagePath()
    for subdir in g:tldr_enabled_categories
      let files = globpath(printf('%s/%s', s:language_folder, subdir), '*.md', 0, 1)
      let s:commands_list += map(files, 'fnamemodify(v:val, ":t:r")')
    endfor
  else
    let s:commands_list = ['init']
  endif
endf

fu! s:GetCmdFilePath(cmd)
  let path = ''
  call s:CheckPagePath()

  for subdir in g:tldr_enabled_categories
    let abspath = printf('%s/%s/%s.md', s:language_folder, subdir, a:cmd)
    if filereadable(abspath)
      let path = abspath
      break
    endif
  endfor

  " fallback default language
  if empty(path)
    for subdir in g:tldr_enabled_categories
      let abspath = printf('%s/%s/%s.md', s:fallback_language_folder, subdir, a:cmd)
      if filereadable(abspath)
        let path = abspath
        break
      endif
    endfor
  endif

  return path
endf

fu! s:LoadText(filepath)
  setlocal modifiable
  " erase buffer content
  norm! ggdG
  silent exec 'r '.a:filepath
  call s:RemoveUselessPatterns()

  silent keepj norm! gg
  setlocal filetype=tldr
  setlocal nomodifiable
endf

fu! s:RemoveUselessPatterns()
  silent exec '%s/{{\|{\|}}\|}/ /ge'
endf

fu! s:CheckPagePath()
  let page_dir = printf('%s/pages.%s', 
        \ expand(g:tldr_directory_path), g:tldr_language)
  call tldr#debug#print('[CheckPagePath] '.page_dir)
  if isdirectory(page_dir)
    let s:language_folder = page_dir
  else
    let s:language_folder = s:fallback_language_folder
  endif
  call tldr#debug#print('[CheckPagePath] '.s:language_folder)
endf

fu! s:GetNewOrExistingWindow()
  if &filetype != 'tldr'
    let thiswin = winnr()
    exec "norm! \<C-W>b"
    if winnr() > 1
      exec 'norm! '.thiswin."\<C-W>w"
      while 1
        if &filetype == 'tldr'
          break
        endif
        exec "norm! \<C-W>w"
        if thiswin == winnr()
          break
        endif
      endwhile
    endif
    if &filetype != 'tldr'
      if g:tldr_split_type == 'vertical'
        exec 'vnew '.s:buffer_name
      elseif g:tldr_split_type == 'tab'
        exec 'tabnew '.s:buffer_name
      else
        exec 'new '.s:buffer_name
      endif
    endif
  endif
endf

fu! tldr#update_docs()
  if s:CheckUnzip()
    if isdirectory(expand(g:tldr_directory_path))
      if s:os == "win"
        silent execute '!rmdir /Q /S "' . expand(g:tldr_directory_path) . '"'
      else
        silent execute '!rm -rf "' . expand(g:tldr_directory_path) . '"'
      endif
    endif

    call s:Print("start to download tldr zip")

    if s:os == "win"
      silent exec '!powershell -c "Invoke-WebRequest -Uri \'' . g:tldr_source_zip_url
      \ . '\' -OutFile \'' . expand(g:tldr_saved_zip_path) . '\'"'
      silent exec '!powershell -c "Expand-Archive -Path \'' . expand(g:tldr_saved_zip_path)
      \ . '\' -DestinationPath \'' . expand("~/.cache/") . '\'"'
      silent exec '!del /S /F "' . expand(g:tldr_saved_zip_path) . '"'
      silent exec '!move /Y ' . expand("~/.cache/tldr-master") . ' '
      \ . expand(g:tldr_directory_path)
    else
      silent exec '!curl -fLo ' . g:tldr_saved_zip_path . ' --create-dirs '
      \ . g:tldr_source_zip_url
      silent exec '!unzip -o -d ~/.cache/ ' . g:tldr_saved_zip_path
      silent exec '!rm -rf ' . g:tldr_saved_zip_path
      silent exec '!mv ~/.cache/tldr-master ' . g:tldr_directory_path
    endif

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
    if path == ''
      call s:Print(a:cmd . ' does not exist!')
    else
      call s:GetNewOrExistingWindow()
      " call s:SetBufferName()
      call s:LoadText(path)
    endif
  endif
endf

let g:autoloaded_tldr = 1

" This is basic vim plugin boilerplate
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set ft=vim et sw=2:
