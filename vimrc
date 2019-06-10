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

" Better navigation, search, find, replace
Plugin 'kien/ctrlp.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'scrooloose/nerdtree'

" Better css, html editing
Plugin 'JulesWang/css.vim'

" Better markdown
Plugin 'plasticboy/vim-markdown'

" Snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Better editing
Plugin 'tpope/vim-commentary'
Plugin 'Raimondi/delimitMate'
Plugin 'junegunn/vim-easy-align'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'w0rp/ale'

" Look and feel
Plugin 'bling/vim-airline'
Plugin 'jonathanfilip/vim-lucius'

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
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set visualbell t_vb=
if WINDOWS()
  set novb
endif

set winaltkeys=no " no alt key in menu

set foldmethod=marker " Folding Stuffs

" Needed for Syntax Highlighting and stuff
filetype plugin indent on
syntax on
set synmaxcol=128
set grepprg=grep\ -nH\ $*

" Cool tab completion stuff
set nohidden " when I close a tab, remove the buffer
set nobackup " turn backup off, since most stuff is in vcs
set nowb
set noswapfile
set autoread " Auto load updates

" Using tabs only
set autoindent  " who doesn't like autoindent?
set smarttab
set tabstop=2
set shiftwidth=2

" }}}
" UI Layout {{{

set number         " show line numbers
set nocursorline   " Don't paint cursor line
set nocursorcolumn " Don't paint cursor column
set lazyredraw     " Wait to redraw
let html_no_rendering=1 " Don't render italic, bold, links in HTML

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
set noshowmatch                 " No show matching brackets/parenthesis
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

if has("gui_running")
	set list
	set listchars=tab:›\ ,trail:•,extends:#,nbsp:. "
endif

" }}}
" Mappings {{{

command E Ex

let mapleader   = ","
let g:mapleader = ","

imap ;; <Esc>
nmap ;; i

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>a :wa!<cr>
nmap <leader>x :x!<cr>
nmap <leader>q :bd!<cr>

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
" map <silent> <S-Left>  <C-w>5<
" map <silent> <S-Right> <C-w>5>
" map <silent> <S-Down>  <C-W>5-
" map <silent> <S-Up>    <C-W>5+
" map <silent> <S-Space> <C-w>=
nnoremap <silent> <Leader>+ :exe "vertical resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "vertical resize " . (winheight(0) * 2/3)<CR>

" Edit vimrc ,ev
if WINDOWS()
  nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/_vimrc<CR>
else
  nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>
endif

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

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

set wildignore+=.svn,.hg,CVS,.git,.cache
set wildignore+=*.scssc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.mp3,*.zip,*.wav,*.mp4,*.ogv,*.webm,*.otf,*.ttf,*.svg,*.woff,*.eot,*.ico,*.dat,*.pdf,*.png,*.jpg,*.gif,*.log,*.lock,*.min.*
set wildignore+=*.min.*

if WINDOWS()
  set wildignore+=*\\rake\\*,*\\tmp\\*,*\\build\\*
else
  set wildignore+=*/rake/*,*/tmp/*,*/build/*
endif

" CtrlP
map <leader>g :CtrlP<cr>
map <leader>t :CtrlPTag<cr>
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_map = '<c-g>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 20
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = [
    \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f'
    \ ]

" Airline
if WINDOWS()
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_symbols = {}
  let g:airline_symbols.space = ' '
else
  if has("gui_running")
		let g:airline_powerline_fonts = 1
		let g:airline#extensions#tabline#enabled = 1
	endif
endif

" NERDtree
nmap <silent> <leader>n :call g:WorkaroundNERDTreeToggle()<CR>
function! g:WorkaroundNERDTreeToggle()
  try | :NERDTreeToggle | catch | :NERDTree | endtry
endfunction
" map <silent> <leader>n :NERDTreeTabsToggle<CR>
let NERDTreeWinSize       = 30
let NERDTreeMouseMode     = 2
let NERDTreeWinPos        = 'left'
let NERDTreeHijackNetrw   = 0
let NERDTreeShowBookmarks = 1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeIgnore = ['\~$','\.[ao]$','\.swp$','\.DS_Store','\.svn','\.CVS','\.hg','\.pyc','\.pyo','\.png','\.gif','\.jpg','\.ico','\.dropbox','\.eot','\.svg','\.ttf','\.woff','\.otf','\.mp4','\.mp3','\.ogv','\.ogg','\.webm','^build-dev$[[dir]]','^build-prod$[[dir]]','^node_modules$[[dir]]','^bower$[[dir]]']
" let g:nerdtree_tabs_open_on_gui_startup = 0
" let g:nerdtree_tabs_autoclose = 0

" EasyGrep
map <leader>f :Grep<Space>
let g:EasyGrepRecursive = 1
let g:EasyGrepCommand = 1
let g:EasyGrepSearchCurrentBufferDir=0
let g:EasyGrepFilesToExclude = ".svn,.hg,CVS,.git,.cache,*.scssc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.mp3,*.zip,*.wav,*.mp4,*.ogv,*.webm,*.otf,*.ttf,*.svg,*.woff,*.eot,*.ico,*.dat,*.pdf,*.png,*.jpg,*.gif,*.log,*.lock,*.min.*"

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Vim Markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

" vim-gutentags
if executable('rg')
	let g:gutentags_file_list_command = 'rg --files'
endif

" ALE
" let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'php': ['php_cs_fixer']
\}
noremap <leader>lf :ALEFix<CR>

" }}}
" GUI Settings {{{

" GVIM- (here instead of .gvimrc)
if has('gui_running')
	" let ayucolor="light"
  " colorscheme ayu
  " colorscheme base16-tomorrow
	colorscheme lucius
	LuciusLight

  " Remove Toolbar
  " Disable scrollbars (real hackers don't use scrollbars for navigation!)
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set guioptions-=T           " Remove the toolbar
  set lines=40                " 40 lines of text instead of 24

  " tab navigation like firefox
  nnoremap <C-S-tab> :tabprevious<CR>
  nnoremap <C-tab>   :tabnext<CR>
  nnoremap <C-t>     :tabnew<CR>
  inoremap <C-S-tab> <Esc>:tabprevious<CR>i
  inoremap <C-tab>   <Esc>:tabnext<CR>i
  inoremap <C-t>     <Esc>:tabnew<CR>

  if LINUX() && has("gui_running")
    set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
  elseif OSX() && has("gui_running")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h14
  elseif WINDOWS() && has("gui_running")
    set guifont=Consolas:h10
  endif
else
  " colorscheme metacosm

  if &term == 'xterm' || &term == 'screen'
    set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
  endif
endif

" }}}
