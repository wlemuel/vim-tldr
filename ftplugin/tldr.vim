if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" buffer local options {{{1
setlocal nonumber
setlocal norelativenumber
setlocal foldcolumn=0
setlocal nofoldenable
setlocal nolist

" scratch buffer options
setlocal buftype=nofile
setlocal bufhidden=hide
setlocal nobuflisted
setlocal noswapfile

" }}}

" mappings {{{1

nnoremap <silent> <buffer> q :exec "q!"<CR>

" }}}

" vim:set ft=vim et sw=2:
