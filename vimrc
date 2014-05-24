" Environment {{{

" Identify platform
silent function! OSX()
  return has('macunix')
endfunction
silent function! LINUX()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
  return  (has('win16') || has('win32') || has('win64'))
endfunction

" }}}
" Vundle {{{

set nocompatible " be iMproved, required
filetype off     " required

if WINDOWS()
  set rtp+=~/vimfiles/bundle/Vundle.vim/
  let path='~/vimfiles/bundle'
  call vundle#begin(path)
else
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
endif

Plugin 'gmarik/Vundle.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-speeddating'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'dkprice/vim-easygrep'
Plugin 'ap/vim-css-color'
Plugin 'Raimondi/delimitMate'
Plugin 'JulesWang/css.vim'
Plugin 'vylight'
Plugin 'chriskempson/vim-tomorrow-theme'

call vundle#end()         " required
filetype plugin indent on " required

" }}}
" Auto Commands {{{

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" }}}
" Misc {{{

" No annoying sound on errors
set t_vb=
set tm=500
set visualbell t_vb=
set noerrorbells
set novisualbell

set winaltkeys=no " no alt key in menu

set foldmethod=marker " Folding Stuffs

" Needed for Syntax Highlighting and stuff
filetype plugin indent on
syntax on
set grepprg=grep\ -nH\ $*

" Cool tab completion stuff
set nohidden " when I close a tab, remove the buffer
set nobackup " turn backup off, since most stuff is in vcs
set nowb
set noswapfile
set autoread " Auto load updates

" Spaces & Tabs
set autoindent  " who doesn't like autoindent?
set expandtab   " spaces are better than a tab character
set smarttab
set shiftwidth=2
set softtabstop=2

set wildignore+=.svn,.hg,CVS,.git,.cache,*.scssc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.mp3,*.zip,*.wav,*.mp4,*.ogv,*.webm,*.otf,*.ttf,*.svg,*.woff,*.eot,*.ico,*.dat,*.pdf,*.png,*.jpg,*.gif,rake/**,solr/**,tmp/**,*.log,*.lock,*.min.*

" }}}
" UI Layout {{{

set number     " show line numbers
set cursorline " highlight current line

if has('cmdline_info')
  set ruler                   " Show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  set showcmd                 " Show partial commands in status line and
endif

if has('statusline')
  set laststatus=2

  " Broken down into easily includeable segments
  set statusline=%<%f\                     " Filename
  set statusline+=%w%h%m%r                 " Options
" set statusline+=%{fugitive#statusline()} " Git Hotness
  set statusline+=\ [%{&ff}/%Y]            " Filetype
  set statusline+=\ [%{getcwd()}]          " Current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" set off the other paren
highlight MatchParen ctermbg=4
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=7                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }}}
" Functions {{{

" <leader>web on a url, opens up google chrome
function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!open -a Google\\ Chrome ".line
endfunction

" Theme Rotating
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
" Mappings {{{

let mapleader   = ","
let g:mapleader = ","

imap ;; <Esc>
nmap ;; i

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>a :wa!<cr>
nmap <leader>x :x!<cr>
nmap <leader>q :q<cr>

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

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Edit gvimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Highlighting
map <silent> <leader><cr> :noh<cr>

" Run from command line
map <leader>cmd :!start cmd /k ""<left>

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

" }}}
" Plugins {{{

" CtrlP
map <leader>g :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_map = '<c-g>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" NERDtree
map <silent> <leader>nn :NERDTreeTabsToggle<CR>
let NERDTreeWinSize       = 30
let NERDTreeMouseMode     = 2
let NERDTreeWinPos        = 'left'
let NERDTreeHijackNetrw   = 0
let NERDTreeShowBookmarks = 1
let NERDTreeIgnore = ['\~$','\.[ao]$','\.swp$','\.DS_Store','\.svn','\.CVS','\.git','\.hg','\.pyc','\.pyo','\.png','\.gif','\.jpg','\.ico','\.dropbox','\.eot','\.svg','\.ttf','\.woff','\.otf','\.mp4','\.mp3','\.ogv','\.ogg','\.webm']
let g:nerdtree_tabs_open_on_gui_startup = 0

" EasyGrep
map <leader>f :Grep<Space>
let g:EasyGrepRecursive = 1
let g:EasyGrepCommand = 1
let g:EasyGrepSearchCurrentBufferDir=0
let g:EasyGrepFilesToExclude = ".svn,.hg,CVS,.git,.cache,*.scssc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.mp3,*.zip,*.wav,*.mp4,*.ogv,*.webm,*.otf,*.ttf,*.svg,*.woff,*.eot,*.ico,*.dat,*.pdf,*.png,*.jpg,*.gif,*.log,*.lock,*.min.*"


" }}}
" GUI Settings {{{

" GVIM- (here instead of .gvimrc)
if has('gui_running')
  colorscheme Tomorrow

  " Remove Toolbar
  " Disable scrollbars (real hackers don't use scrollbars for navigation!)
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=T           " Remove the toolbar
  set lines=40                " 40 lines of text instead of 24
  nmap <C-S-tab>       :tabprevious <CR>
  map  <C-S-tab>       :tabprevious <CR>
  imap <C-S-tab> <Esc> :tabprevious <CR>i
  nmap <C-tab>         :tabnext     <CR>
  map  <C-tab>         :tabnext     <CR>
  imap <C-tab>   <Esc> :tabnext     <CR>i

  if LINUX() && has("gui_running")
    set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
  elseif OSX() && has("gui_running")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h12
  elseif WINDOWS() && has("gui_running")
    set guifont=Consolas:h10
  endif
else
  if &term == 'xterm' || &term == 'screen'
    set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
  endif
else
  colorscheme metacosm
endif

" }}}
