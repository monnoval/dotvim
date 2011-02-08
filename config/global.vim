"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
filetype indent plugin on

set autoread " Set to auto read when a file is changed from the outside
set number " show line numbers
set showcmd " show partial command in status line
set showmode " show whether in insert, visual mode etc
set splitbelow " split creates new window below current one

" When vimrc is edited, reload it
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
"
" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source $MYVIMRC

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 5 lines to the curors - when moving vertical..
set so=5

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set magic "Set magic on, for regular expressions
set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl
set nocompatible

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smarttab
set tabstop=2
set shiftwidth=2
set expandtab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

set laststatus=2 " Always hide the statusline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.lzx    set filetype=lzx
au BufRead,BufNewFile *.j      set filetype=objj
au BufRead,BufNewFile *.php    set filetype=php
au BufRead,BufNewFile *.wiki   set filetype=creole
au BufRead,BufNewFile *.sass   set filetype=css
au BufRead,BufNewFile *.scss   set filetype=css
au BufRead,BufNewFile *.html   set filetype=html
au BufRead,BufNewFile *.htm    set filetype=html
au BufRead,BufNewFile *.aspx   set filetype=html
au BufRead,BufNewFile *.ascx   set filetype=html
au BufRead,BufNewFile *.master set filetype=html

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

" Enable Closetag in xml based files
if MySys() == "windows"
  au Filetype master,ascx,aspx,php,html,htm,xml,xsl source ~/vimfiles/bundle/closetag.vim/plugin/closetag.vim
else
  au Filetype master,ascx,aspx,php,html,htm,xml,xsl source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
endif
