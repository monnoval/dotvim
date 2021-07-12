# Mon's VIM settings

Currently, as of 2021, this vimrc is only tested on macOS Mojave and KDE neon.

## Requirements

- rg - https://github.com/BurntSushi/ripgrep
- ctags - https://formulae.brew.sh/formula/ctags

## Features

- File browser in left side of screen
- Easy move between multiple windows and tabs

## Todo

- (none fo now maybe)

### Plugins

- [vim-plug](https://github.com/junegunn/vim-plug)
- [nerdtree](http://github.com/preservim/nerdtree)
- [snipmate](http://github.com/garbas/vim-snipmate)
- [commentary](http://github.com/tpope/vim-commentary)
- [airline](http://github.com/bling/vim-airline)
- [lucius](https://github.com/jonathanfilip/vim-lucius)
- [fzf](https://github.com/junegunn/fzf.vim)
- [fugitive](https://github.com/tpope/vim-fugitive)

### Key bindings

#### Basics

- `,` much efficient replacement as leader key
- `;;` switch between normal and insert mode
- `,w` save current file, eq `:w!`
- `,a` save all files open, eq `:wa!`
- `,x` exit current file, eq `:x!`
- `,q` quit current file, eq `:bd!`
- `,ev` edit vimrc
- `,sv` source vimrc

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

- `,g` use ctrlp to search files
- `,f` find string in all files using easygrep
- `,n` open file browser, using nerdtree

