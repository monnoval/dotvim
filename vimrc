call plug#begin()

" Plug 'dstein64/vim-startuptime'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'dyng/ctrlsf.vim'
Plug 'ludovicchabant/vim-gutentags'

" Better vim
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Better css, html editing
Plug 'JulesWang/css.vim'
Plug 'mustache/vim-mustache-handlebars'

" Better markdown
Plug 'plasticboy/vim-markdown'

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'dcampos/nvim-snippy'
Plug 'honza/vim-snippets'

" Better editing
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'szw/vim-maximizer'
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'

" todo.txt
Plug 'dbeniamine/todo.txt-vim'

" Look and feel
Plug 'itchyny/lightline.vim'
Plug 'dikiaap/minimalist'
Plug 'sainnhe/gruvbox-material'

" Calendar
Plug 'itchyny/calendar.vim'

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
" set maxmempattern=500000

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
if has('termguicolors')
  set termguicolors
endif
set background=dark
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

" Cool tab completion stuff
set nohidden " when I close a tab, remove the buffer
set nobackup " turn backup off, since most stuff is in vcs
set nowb
set noswapfile

" Make autoread work properly
" https://unix.stackexchange.com/a/383044
set autoread " Auto load updates

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Using tabs only
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

" if has("gui_running")
"   set listchars=tab:›\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»
" endif

" }}}
" Mappings {{{

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

" Yoink
set clipboard^=unnamed
let g:yoinkIncludeDeleteOperations = 1
" let g:yoinkSyncSystemClipboardOnFocus = 0
nmap <expr> p yoink#canSwap() ? '<plug>(YoinkPostPasteSwapBack)' : '<plug>(YoinkPaste_p)'
nmap <expr> P yoink#canSwap() ? '<plug>(YoinkPostPasteSwapForward)' : '<plug>(YoinkPaste_P)'

" gutentags
let g:gutentags_file_list_command = 'rg --files --follow'

" Ignores
set wildignore+=.svn,.hg,CVS,.git,.cache,.sass-cache,tags
set wildignore+=*.scssc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.mp3,*.zip,*.wav,*.mp4,*.ogv,*.webm,*.otf,*.ttf,*.svg,*.woff,*.eot,*.ico,*.dat,*.pdf,*.png,*.jpg,*.jpeg,*.gif,*.log,*.lock,*.min.*,*.map,tags.*
set wildignore+=*/rake/*,*/tmp/*,*/build/*

" snippy
imap <expr> <Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-advance)' : '<Tab>'
imap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
smap <expr> <Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>'
smap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
xmap <Tab> <Plug>(snippy-cut-text)

" FZF
map <leader>g :Files!<cr>
map <leader>b :Buffers!<cr>
map <leader>t :Tags!<cr>
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
" Fix tabstop when using Buffers
command! -bang -nargs=? Buffers
    \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': ['--tabstop=2']}), <bang>0)

" ctrlsf.vim
vmap <S-F> <Plug>CtrlSFVwordExec

" vim-cutlass
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" Lightline
let g:lightline = {'colorscheme':'gruvbox_material'}

" NERDtree
nmap <silent> <leader>n :call g:WorkaroundNERDTreeToggle()<CR>
function! g:WorkaroundNERDTreeToggle()
  try | :NERDTreeToggle | catch | :NERDTree | endtry
endfunction
let NERDTreeWinSize           = 30
let NERDTreeMouseMode         = 2
let NERDTreeWinPos            = 'left'
let NERDTreeHijackNetrw       = 0
let NERDTreeAutoDeleteBuffer  = 1
let NERDTreeRespectWildIgnore = 1
let NERDTreeLazyDirRefresh    = 1
let NERDTreeIgnore = ['\~$','\.[ao]$','\.swp$','\.DS_Store','\.svn','\.CVS','\.hg','\.pyc','\.pyo','\.png','\.gif','\.jpg','\.jpeg','\.ico','\.dropbox','\.eot','\.svg','\.ttf','\.woff','\.otf','\.mp4','\.mp3','\.ogv','\.ogg','\.webm','\.zip','\.gz','\.map','^build$[[dir]]','^build-dev$[[dir]]','^build-prod$[[dir]]','^node_modules$[[dir]]','^bower$[[dir]]','^bower_components$[[dir]]']
let NERDTreeMapToggleFileLines=',l'

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
" different colorscheme for todo
autocmd FileType todo let g:gruvbox_material_background = 'hard'
autocmd FileType todo colorscheme gruvbox-material

" Calendar
let g:calendar_clock_12hour=1
let g:calendar_first_day = "sunday"
let g:calendar_cache_directory = printf('%s/Sync/shared/todo/calendar.vim/', $HOME)
let g:calendar_date_full_month_name=1
nnoremap <silent> <Leader>c :Calendar<CR>
nnoremap <silent> <Leader>cv :Calendar -view=year -split=vertical -width=27<CR>
nnoremap <silent> <Leader>ch :Calendar -view=year -split=horizontal -position=below -height=12<CR>
nnoremap <silent> <Leader>cw :Calendar -view=week -split=horizontal -position=below -height=12<CR>

" vim-commentary
autocmd FileType php setlocal commentstring=//\ %s

" }}}
" GUI Settings {{{
" Misc

autocmd! FileType fzf tnoremap <expr> <C-r> getreg(nr2char(getchar()))
vnoremap <C-c> "+y
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>

" Neovide
if exists("g:neovide")
	set guifont=Fira\ Code:h11
	let g:neovide_cursor_vfx_mode = "railgun"
	let g:neovide_cursor_animation_length = 0.08
endif

" }}}
