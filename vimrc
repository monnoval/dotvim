call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'dyng/ctrlsf.vim'
Plug 'svermeulen/vim-cutlass'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'

" Better css, html editing
Plug 'JulesWang/css.vim'
Plug 'mustache/vim-mustache-handlebars'

" Better markdown
Plug 'plasticboy/vim-markdown'

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" Better editing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'

" todo.txt
Plug 'dbeniamine/todo.txt-vim'

" Look and feel
Plug 'bling/vim-airline'
Plug 'jonathanfilip/vim-lucius'

" Initialize plugin system
call plug#end()

" Environment {{{
" Identify platform
silent function! OSX()
  return has('macunix')
endfunction
silent function! LINUX()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction

" }}}
" Auto Commands {{{

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
"
set maxmempattern=500000

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set visualbell t_vb=
set winaltkeys=no " no alt key in menu

" Needed for Syntax Highlighting and stuff
filetype plugin indent on
syntax on
set grepprg=grep\ -nH\ $*
colorscheme lucius
LuciusDarkLowContrast

" Cool tab completion stuff
set nohidden " when I close a tab, remove the buffer
set nobackup " turn backup off, since most stuff is in vcs
set nowb
set noswapfile
set autoread " Auto load updates

" Using tabs only
" set autoindent  " who doesn't like autoindent?
" set smarttab
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
set foldenable                  " Auto fold code

if has("gui_running")
  set list
  set listchars=tab:›\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»
endif

" }}}
" Mappings {{{

" command E Ex

" command gpm Gpush origin master
" command gpd Gpush origin dev
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("gpm", "Git push origin master")
call SetupCommandAlias("gpd", "Git push origin dev")
call SetupCommandAlias("gs",  "Git")
call SetupCommandAlias("gc",  "Git commit")
call SetupCommandAlias("gl",  "Gclog")

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

" Maps CMD+S-[h,j,k,l] to resizing a window split
" map <silent> <leader>rl :vertical resize -5<cr>
" map <silent> <leader>rh :vertical resize +5<cr>
" map <silent> <leader>rk :resize +5<cr>
" map <silent> <leader>rj :resize -5<cr>
map <silent> <A-S-h> :vertical resize -3<cr>
map <silent> <A-S-l> :vertical resize +3<cr>
map <silent> <A-S-j> :resize +3<cr>
map <silent> <A-S-k> :resize -3<cr>

" Edit vimrc ,ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Source .vimrc ,sv
nnoremap <silent> <Leader>sv :source ~/.vimrc<CR>

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

" toggle showing of invisible characters
nmap <leader>l :set invlist<cr>

" using retab causes issues when mixed with tabs/space
nmap <leader>rt :set noet<cr>:%retab!<cr>

" }}}
" Plugins {{{

let g:gutentags_file_list_command = 'rg --files --follow'

set wildignore+=.svn,.hg,CVS,.git,.cache,.sass-cache,tags
set wildignore+=*.scssc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.mp3,*.zip,*.wav,*.mp4,*.ogv,*.webm,*.otf,*.ttf,*.svg,*.woff,*.eot,*.ico,*.dat,*.pdf,*.png,*.jpg,*.jpeg,*.gif,*.log,*.lock,*.min.*,*.map,tags.*
set wildignore+=*/rake/*,*/tmp/*,*/build/*


" Snipmate depraciation proces
" https://github.com/garbas/vim-snipmate/commit/f883bac7c493b0078956543f5700c5443dac72c7
let g:snipMate = { 'snippet_version' : 1 }

" FZF
map <leader>g :Files<cr>
map <leader>b :Buffers<cr>
map <leader>t :Tags<cr>
map <leader>f :Rg!<cr>
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let $FZF_DEFAULT_COMMAND = 'rg --files --follow'
let $FZF_DEFAULT_OPTS = '--tabstop=2'
let g:fzf_tags_command = "ctags -R --options=$HOME/.ctags"
set grepprg=rg\ --vimgrep

" ctrlsf.vim
if OSX() && has("gui_running")
  nmap <D-F> <Plug>CtrlSFPrompt
  vmap <D-F> <Plug>CtrlSFVwordExec
endif
if ! has("gui_running") && &term == 'nvim' "nvim-qt
  vmap <S-F> <Plug>CtrlSFVwordExec
endif


" vim-cutlass
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" Airline
if has("gui_running") || &term == 'nvim' "nvim-qt
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1
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
" let NERDTreeShowBookmarks = 1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeRespectWildIgnore=1
let NERDTreeIgnore = ['\~$','\.[ao]$','\.swp$','\.DS_Store','\.svn','\.CVS','\.hg','\.pyc','\.pyo','\.png','\.gif','\.jpg','\.jpeg','\.ico','\.dropbox','\.eot','\.svg','\.ttf','\.woff','\.otf','\.mp4','\.mp3','\.ogv','\.ogg','\.webm','\.zip','\.gz','\.map','^build$[[dir]]','^build-dev$[[dir]]','^build-prod$[[dir]]','^node_modules$[[dir]]','^bower$[[dir]]','^bower_components$[[dir]]']
" let g:nerdtree_tabs_open_on_gui_startup = 0
" let g:nerdtree_tabs_autoclose = 0

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Vim Markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

" todo-txt
let maplocalleader="\\"
let $TODO_DIR = printf('%s/Sync/shared/todo', $HOME)
au BufNewFile,BufRead $TODO_DIR/*.txt set filetype=todo

" }}}
" GUI Settings {{{

" GVIM- (here instead of .gvimrc)
if has('gui_running')
  " Remove Toolbar
  " Disable scrollbars (real hackers don't use scrollbars for navigation!)
  " set guioptions-=r
  " set guioptions-=R
  set guioptions-=l
  set guioptions-=L

  if OSX() && has("gui_running")
    set guioptions-=T " Remove the toolbar
  endif

  set lines=40      " 40 lines of text instead of 24

  " tab navigation like firefox
  nnoremap <C-S-tab> :tabprevious<CR>
  nnoremap <C-tab>   :tabnext<CR>
  nnoremap <C-t>     :tabnew<CR>
  inoremap <C-S-tab> <Esc>:tabprevious<CR>i
  inoremap <C-tab>   <Esc>:tabnext<CR>i
  inoremap <C-t>     <Esc>:tabnew<CR>

  if LINUX() && has("gui_running")
    nnoremap y "+y
    vnoremap <C-x> "+c
    vnoremap <C-c> "+y
    " vnoremap <C-v> c<ESC>"+p

    inoremap <C-v> <ESC>"+pa
    " inoremap <C-V> <C-O>:set paste<CR><C-R><C-R>+<C-O>:set nopaste<CR>

    nnoremap <C-s> :w<CR>
    nnoremap <C-q> :q<CR>
    cnoremap <C-v> <C-r>"
    set clipboard^=unnamedplus
  endif

  if LINUX() && has("gui_running")
    set guifont=Noto\ Mono\ for\ Powerline\ 10
  elseif OSX() && has("gui_running")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h14
  endif
else

  if &term == 'xterm-256color'
    nnoremap y "+y
    vnoremap <C-x> "+c
    vnoremap <C-c> "+y
    inoremap <C-S-v> <ESC>"+pagg
    nnoremap <C-s> :w<CR>
    nnoremap <C-q> :q<CR>
    cnoremap <C-S-v> <C-r>"
		set mouse=a
	elseif &term == 'xterm' || &term == 'screen'
    set t_Co=256 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
  endif
endif

" }}}
