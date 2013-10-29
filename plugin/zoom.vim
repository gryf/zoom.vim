"The guard. Zoom will only work in graphical Vim. For terminal version try to
"find out how to increase/decrease font size in your terminal emulator.
if !has("gui")
  finish
endif

if &cp || exists("g:loaded_zoom")
    finish
endif
let g:loaded_zoom = 1

let s:save_cpo = &cpo
set cpo&vim

" keep default value
let s:current_font = &guifont

" command
command! -narg=0 ZoomIn    :call s:ZoomIn()
command! -narg=0 ZoomOut   :call s:ZoomOut()
command! -narg=0 ZoomReset :call s:ZoomReset()

" map. I like keypad mappings
nmap <kPlus> :ZoomIn<CR>
nmap <kMinus> :ZoomOut<CR>
nmap <kDivide> :ZoomReset<CR>

nmap <C-ScrollWheelUp> :ZoomIn<CR>
nmap <C-ScrollWheelDown> :ZoomOut<CR>

" guifont size + 1
function! s:ZoomIn()
  " Let's check, what system we are dealing with
  if has("win32")
    let l:fsize = substitute(&guifont, '^.*:h\([^:]*\).*$', '\1', '')
    let l:fsize += 1
    let l:guifont = substitute(&guifont, ':h\([^:]*\)', ':h' . l:fsize, '')
    let &guifont = l:guifont
  elseif has('unix')
    " TODO: Might not work on OS X
    let l:font = split(&guifont)
    let l:font[-1] = l:font[-1] + 1
    let &guifont = join(l:font, " ")
  endif
endfunction

" guifont size - 1
function! s:ZoomOut()
  " Same as above
  if has("win32")
    let l:fsize = substitute(&guifont, '^.*:h\([^:]*\).*$', '\1', '')
    let l:fsize -= 1
    let l:guifont = substitute(&guifont, ':h\([^:]*\)', ':h' . l:fsize, '')
    let &guifont = l:guifont
  elseif has('unix')
    let l:font = split(&guifont)
    let l:font[-1] = l:font[-1] - 1
    let &guifont = join(l:font, " ")
  endif
endfunction

" reset guifont size
function! s:ZoomReset()
  let &guifont = s:current_font
endfunction

let &cpo = s:save_cpo
finish

==============================================================================
zoom.vim : control gui font size with "+" or "-" keypad keys.
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/zoom.vim
==============================================================================
author  : OMI TAKU
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2008/07/18 10:00:00
==============================================================================

Control Vim editor font size with keyboard or mouse.
This plugin is for GUI only.


Normal Mode:
    Keypad +              ... incerase font size
    Ctrl-MouseWheelUp

    Keypad -              ... decrease font size
    Ctrl-MouseWheelDown   

    Keypad /              ... reset font size to initial state

Command-line Mode:
    :ZoomIn               ... incerase font size
    :ZoomOut              ... decrease font size
    :ZoomReset            ... reset font size to initial state

==============================================================================

1. Copy the zoom.vim script to
   $HOME/vimfiles/plugin or $HOME/.vim/plugin directory.
   Refer to ':help add-plugin', ':help add-global-plugin' and
   ':help runtimepath' for more details about Vim plugins.
   Or just use pathogen (https://github.com/tpope/vim-pathogen)

2. Restart Vim.

==============================================================================
" vim: set ff=unix et ft=vim nowrap :
