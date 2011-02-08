" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "," 
let g:mapleader = "," 

imap ;; <Esc>
nmap ;; i

" Fast editing of the .vimrc
if MySys() == "windows"
  map <leader>e :e! ~/vimfiles/vimrc<cr>
else
  map <leader>e :e! ~/.vim/vimrc<cr>
endif

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>a :wa!<cr>
nmap <leader>x :x!<cr>
nmap <leader>q :q<cr>

map <leader>t2 :setlocal shiftwidth=2<cr>
map <leader>t4 :setlocal shiftwidth=4<cr>
map <leader>t8 :setlocal shiftwidth=4<cr>

" Set backspace
imap <C-BS> <C-W>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, buffers and folds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting
map <silent> <leader><cr> :noh<cr>
map <silent> <leader>jz :if exists("syntax_on") <Bar>
	\   syntax off <Bar>
	\ else <Bar>
	\   syntax enable <Bar
	\ endif <CR>
map <silent> <leader>jl :set cursorline!<CR>
map <silent> <leader>jc :syntax on<CR>

" Quickly set comma or semicolon at the end of the string
inoremap ,, <End>,

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" No alt key in menu
set winaltkeys=no

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-h> <C-w>5<
map <silent> <A-l> <C-w>5>
map <silent> <A-j> <C-W>5-
map <silent> <A-k> <C-W>5+
map <silent> <S-A-h> <C-w>h<C-w><bar>
map <silent> <S-A-l> <C-w>l<C-w><bar>
map <silent> <S-A-j> <C-w>j<C-w>_
map <silent> <S-A-k> <C-w>k<C-w>_
map <silent> <S-A-k> <C-w>k<C-w>_
map <silent> <S-Space> <C-w>=
map <silent> <C-Space> <C-w><bar><C-w>_

" Maps Alt-[s.v] to horizontal and vertical split respectively
map <silent> <A-s> :split<cr>
map <silent> <A-v> :vsplit<cr>
map <silent> <A-e> :vsplit<cr><C-W>l:E<cr>
map <silent> <A-t> :tabnew<cr>:E<cr>

" Tab navigation like firefox
nmap <C-t>       :tabnew<cr>
imap <C-t> <Esc> :tabnew<cr>

" Open and close fold with Space. Create fold with visual selection Space.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<cr>
vnoremap <Space> zf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <A-S-j> mz:m+<cr>`z
nmap <A-S-k> mz:m-2<cr>`z
vmap <A-S-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <A-S-k> :m'<-2<cr>`>my`<mzgv`yo`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Copy and Paste using <F8>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"copy
vmap <A-p> "+ygv"zy`>
"paste (Alt-Shift-p to paste after normal cursor, Ctrl-p to paste over visual selection)
nmap <A-p> "zgP
nmap <A-S-p> "zgp
imap <A-p> <C-r><C-o>z
vmap <C-p> "zp`]
cmap <A-p> <C-r><C-o>z
"copy register
autocmd FocusGained * let @z=@+

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Set vim to change directory for each file
if exists('+autochdir')
  set autochdir
else 
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

" For making snippets
" nmap <leader>r p0dwkdd:w!<cr>:E<cr>%
