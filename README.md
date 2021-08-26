# Mon's VIM settings

Currently, as of 2021, this vimrc is only tested on KDE neon, Manjaro XFCE and Fedora 34.

## Requirements

- [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-package)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [ctags](https://docs.ctags.io/en/latest/index.html)

## Installation

```shell
$ ln -s /custom/dir/dotvim/nvim  ~/.config/nvim
$ ln -s /custom/dir/dotvim/vimrc ~/.vimrc
$ ln -s /custom/dir/dotvim/ctags ~/.ctags

# install vim-plug via neovim
$ sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Open nvim, do :PlugInstall to install plugins.

## Features

- File browser in left side of screen
- Easy move between multiple windows and tabs

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
- `ctrl+alt-h` or `ctrl+alt-l` resize horizontally
- `ctrl+alt-j` or `ctrl+alt-k` resize vertically
- `ctrl+j` move down
- `ctrl+k` move up
- `ctrl+h` move left
- `ctrl+l` move right

#### Plugins

- `,g` to search files
- `,f` find string in all files
- `,n` open file browser, using nerdtree
