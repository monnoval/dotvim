" Enable Mouse
set mouse=a
set clipboard=unnamed

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! Noto\ Mono\ for\ Powerline:h10
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv

" nnoremap y "+y
" nnoremap yy "+y
vnoremap <C-x> "+c
vnoremap <C-c> "+y
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
inoremap <C-v> <C-R><C-O>+
cnoremap <C-v> <C-R><C-O>+

"Enable CTRL-V in terminal mode
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
