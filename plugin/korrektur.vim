" Vim global plugin for correcting typing mistakes
" Last Change:
" Maintainer:
" License: This file is placed in the public domain.
" File name: plugin/korrektur.vim

" Avoid reloading of script functions if already loaded
if exists("g:loaded_korrektur")
  finish
endif
let g:loaded_korrektur = 1

" vi-compatibility cpoptions single char flags for vim
" Disable cpo to utilise vim features like multi-line expression etc.
let s:save_cpo = &cpo
set cpo&vim

" abbreviation list
iabbrev teh the
iabbrev otehr other
iabbrev wnat want
iabbrev synchronisation
	\ synchronization
let s:count = 4

" unique key mapping
if !hasmapto('<Plug>KorrekturAdd')
  map <unique> <Leader>a  <Plug>KorrekturAdd
endif
noremap <unique> <script> <Plug>KorrekturAdd  <SID>Add

noremenu <script> Plugin.Add\ Correction      <SID>Add

noremap <SID>Add  :call <SID>Add(expand("<cword>"), 1)<CR>


function s:Add(from, correct)
  let to = input("type the correction for " . a:from . ": ")
  exe ":iabbrev " . a:from . " " . to
  if a:correct | exe "normal viws\<C-R>\" \b\e" | endif
  let s:count = s:count + 1
  echo s:count . " corrections now"
endfunction

if !exists(":Correct")
  command -nargs=1  Correct  :call s:Add(<q-args>, 0)
endif

" Revert cpoptions settings
let &cpo = s:save_cpo
