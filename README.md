# Mon's VIM settings

This Vim configuration is meant for both macvim and gvim on windows. I switch to both Mac and Windows daily for both work and personal stuff. Having one Vim setting for both is easily maintainable.

## Features

- Works both Mac and Windows
- File browser in left side of screen
- Easy move between multiple windows and tabs

## Todo

- Use fugitive for git
- Use fugitive equivalent for hg

### Plugins

- [vundle](http://github.com/gmarik/Vundle.vim)
- [ctrlp](http://github.com/kien/ctrlp.vim)
- [easygrep](http://github.com/dkprice/vim-easygrep)
- [nerdtree](http://github.com/scrooloose/nerdtree)
- [snipmate](http://github.com/garbas/vim-snipmate)
- [commentary](http://github.com/tpope/vim-commentary)
- [speeddating](http://github.com/tpope/vim-speeddating)
- [delimitMate](http://github.com/Raimondi/delimitMate)
- [airline](http://github.com/bling/vim-airline)
- [tomorrow-theme](http://github.com/chriskempson/vim-tomorrow-theme)

### Key bindings

#### Basics

- `,` much efficient replacement as leader key
- `;;` switch between normal and insert mode
- `,w` save current file, eq `:w!`
- `,a` save all files open, eq `:wa!`
- `,x` exit current file, eq `:x!`
- `,q` quit current file, eq `:bd!`
- `,ev` edit vimrc

#### Movements

- `,s` split window horizontally, eq `:split`
- `,v` split window vertically, eq `:vplit`
- `,e` split window vertically then open netrw, eq `:vsplit<cr><C-W>l:E`
- `ctrl+j` move down
- `ctrl+k` move up
- `ctrl+h` move left
- `ctrl+l` move right

#### Fixes

- `,m` remove all ^M - when the encodings gets messed up
- `alt+c` copy in windows env
- `alt+v` paste in windows env

#### Plugins

- `,g` use ctrlp
- `,f` find string in all files using easygrep
- `,n` open file browser, using nerdtree

