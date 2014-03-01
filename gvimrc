" Fullscreen takes up entire screen
set fuoptions=maxhorz,maxvert

" start without the toolbar
set guioptions-=T

" remove ugly scrollbars
set guioptions=aAce

colorscheme lucius
set background dark
set guifont=Menlo:h12

"Used by Rails plugin
command-bar -nargs=1 OpenURL :!open <args>

if has("gui_macvim")
  " Command-T for CommandT
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CtrlP<CR>
  imap <D-t> <Esc>:CtrlP<CR>

  macmenu Window.Toggle\ Full\ Screen\ Mode key=<nop>
  map <D-F> :Ag<space>

  let g:fullscreen_colorscheme = "iawriter"
  let g:fullscreen_font = "Cousine:h14"
  let g:normal_colorscheme = "lucius"
  let g:normal_font="Menlo:h12"
endif





