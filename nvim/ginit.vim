" Enable Mouse
set mouse=a
set clipboard=unnamed

if exists('g:GuiLoaded')
    set listchars=tab:›\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»
    nnoremap <C-S-tab> :tabprevious<CR>
    nnoremap <C-tab>   :tabnext<CR>
    nnoremap <C-t>     :tabnew<CR>
    inoremap <C-S-tab> <Esc>:tabprevious<CR>i
    inoremap <C-tab>   <Esc>:tabnext<CR>i
    inoremap <C-t>     <Esc>:tabnew<CR>
endif

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! Fira Code:h11
endif

silent function! OSX()
  return has('macunix')
endfunction
if OSX() && exists(':GuiFont')
    GuiFont! Noto\ Mono\ for\ Powerline:h14
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

" Weird issue regarding copy paste when using Wayland
" https://github.com/equalsraf/neovim-qt/issues/298#issuecomment-533873100
" call GuiClipboard()

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

" Disable middle mouse click paste feature
" https://superuser.com/a/242822
nnoremap <MiddleMouse> <Nop>
nnoremap <2-MiddleMouse> <Nop>
nnoremap <3-MiddleMouse> <Nop>
nnoremap <4-MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>
inoremap <2-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>

" Enable CTRL-V in terminal mode
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

