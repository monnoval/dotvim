"{{{Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
set rtp+=~/vimfiles/bundle/Vundle.vim/
let path='~/vimfiles/bundle'
call vundle#begin(path)
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" https://github.com/garbas/vim-snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"

" https://github.com/kien/ctrlp.vim
Bundle "kien/ctrlp.vim"

" https://github.com/bling/vim-airline
Plugin 'bling/vim-airline'

" Themes
Plugin 'vylight'
Plugin 'chriskempson/vim-tomorrow-theme'

" NERDTree
Plugin 'scrooloose/nerdtree'
" NERDTree Tabs
Plugin 'jistr/vim-nerdtree-tabs'

" VIM Commentary
Plugin 'tpope/vim-commentary'

" Ack
Plugin 'dkprice/vim-easygrep'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"}}}

"{{{Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()



"}}}

"{{{VIM user interface

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set visualbell t_vb=
set novb

"}}}

"{{{Misc Settings

" Necesary  for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=2
set softtabstop=2

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Real men use gcc
" compiler gcc

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Got backspace?
set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
" inoremap jj <Esc>

" nnoremap JJJJ <Nop>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Auto load updates
set autoread

" }}}

"{{{Look and Feel

" Set font according to system
if has("mac") || has("macunix")
    set gfn=Source\ Code\ Pro\ for\ Powerline:h13,Menlo:h13
elseif has("win16") || has("win32")
    " do nothing
elseif has("linux")
    set gfn=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Remove Toolbar
" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

if has("gui_running")
   colorscheme Tomorrow
else
   colorscheme metacosm
endif

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" }}}

"{{{ Functions

"{{{ Open URL in browser

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!open -a Google\\ Chrome ".line
endfunction

"}}}

"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "Tomorrow#vylight#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
" }}}

"}}}

"{{{ Mappings

let mapleader = ","
let g:mapleader = ","

imap ;; <Esc>
nmap ;; i

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>a :wa!<cr>
nmap <leader>x :x!<cr>
nmap <leader>q :q<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove<CR>
map <leader>tn :tabnext<CR>

" Horizontal and vertical split respectively
map <silent> <leader>s :split<cr>
map <silent> <leader>v :vsplit<cr>
map <silent> <leader>e :vsplit<cr><C-W>l:E<cr>

" No alt key in menu
set winaltkeys=no

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <S-Left>  <C-w>5<
map <silent> <S-Right> <C-w>5>
map <silent> <S-Down>  <C-W>5-
map <silent> <S-Up>    <C-W>5+
map <silent> <S-Space> <C-w>=

" Open Url on this line with the browser ,web
map <Leader>web :call Browser ()<CR>
" http://google.com

" Next Tab
nnoremap <silent> <C-Tab> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Rotate Color Scheme <F8>
nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

" DOS is for fools.
" nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/_vimrc<CR>

" Edit gvimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Good call Benjie (r for i)
nnoremap <silent> <Home> i <Esc>r
nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Testing
set completeopt=longest,menuone,preview

inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Highlighting
map <silent> <leader><cr> :noh<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Copy and Paste using Alt+p
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"copy
vmap <A-c> "+ygv"zy`>
"paste (Alt-Shift-p to paste after normal cursor, Ctrl-p to paste over visual selection)
nmap <A-v> "zgP
nmap <A-S-v> "zgp
imap <A-v> <C-r><C-o>z
vmap <A-v> "zp`]
cmap <A-v> <C-r><C-o>z
"copy register
autocmd FocusGained * let @z=@+

"}}}

"{{{Plugins Settings

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>g :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_map = '<c-g>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_symbols = {}
let g:airline_symbols.space = ' '

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>nn :NERDTreeTabsToggle<CR>
let NERDTreeWinSize       = 30
let NERDTreeMouseMode     = 2
let NERDTreeWinPos        = 'left'
let NERDTreeHijackNetrw   = 0
let NERDTreeShowBookmarks = 1
let NERDTreeIgnore = ['\~$','\.[ao]$','\.swp$','\.DS_Store','\.svn','\.CVS','\.git','\.hg','\.pyc','\.pyo','\.png','\.gif','\.jpg','\.dropbox']
let g:nerdtree_tabs_open_on_gui_startup = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Easy Grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map <leader>f :! perl \\"C:\Users\User\vimfiles\ack-standalone.pl\\"

"}}}

filetype plugin indent on
syntax on

