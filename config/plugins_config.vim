"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Yankring
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>y  :YRShow<CR>
let g:yankring_history_dir  = '~/'
let g:yankring_history_file = '.vim-yankring'
let g:yankring_min_element_length = 2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>nn :NERDTree<CR>
map <silent> <leader>nm :NERDTreeMirror<CR>
let NERDTreeWinSize     = 20
let NERDTreeMouseMode   = 2
let NERDTreeWinPos      = 'right'
let NERDTreeHijackNetrw = 0
let NERDTreeIgnore = ['\~$','\.[ao]$','\.swp$','\.DS_Store','\.svn','\.CVS','\.git','\.hg','\.pyc','\.pyo','\.png','\.gif','\.jpg','\.dropbox']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => BufExplorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>bb :BufExplorer<cr>
map <silent> <leader>bh :BufExplorerHorizontalSplit<cr>
map <silent> <leader>bv :BufExplorerVerticalSplit<cr>
let g:bufExplorerDefaultHelp      = 0 " Do not show default help.
let g:bufExplorerShowDirectories  = 0 " Don't show directories.
let g:bufExplorerShowRelativePath = 1 " Show relative paths.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fuzzy finder
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>ff :FufFile **/<cr>
map <silent> <leader>fd :FufFileWithCurrentBufferDir **/<cr>
map <silent> <leader>fr :FufRenewCache<cr>
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|swp|png|jpg|gif|psd)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_dir_exclude = '\v(^|[/\\])\.(hg|git|bzr)($|[/\\])'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Zen Coding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_zen_expandabbr_key = '<c-e>'
let g:user_zen_settings = {
\ 'php' : {
\ 'extends' : 'html',
\ 'filters' : 'c',
\ },
\ 'xml' : {
\ 'extends' : 'html',
\ },
\ 'haml' : {
\ 'extends' : 'html',
\ },
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Django Snipmate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd FileType python set ft=python.django
" autocmd FileType html set ft=html.django_template

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ConqueTerm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ConqueTerm_Color = 0
map <silent> <A-s> :5split<cr>:ConqueTerm bash<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimWiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if MySys() == "windows"
  let g:vimwiki_list = [{'path': '~/vimfiles/doc/vimwiki', 'path_html': '~/vimfiles/doc/vimwiki'}]
else
  let g:vimwiki_list = [{'path': '~/.vim/doc/vimwiki', 'path_html': '~/.vim/doc/vimwiki'}]
endif

map <Leader>dt <Plug>VimwikiTabMakeDiaryNote

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indent Guides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_auto_colors = 0 
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#efefef   ctermbg=3 
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#f7f7f7 ctermbg=4 
let g:indent_guides_start_level = 2

