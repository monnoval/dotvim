" Load plugins using Pathogen
filetype off
call pathogen#runtime_append_all_bundles()

" Color Support
colorscheme vylight 

if MySys() == "windows"
  source ~/vimfiles/config/global.vim
  source ~/vimfiles/config/functions.vim
  source ~/vimfiles/config/keybindings.vim
  source ~/vimfiles/config/plugins_config.vim
  if filereadable(expand("~/vimfiles/config/vimrc_custom"))
    source ~/vimfiles/config/vimrc_custom
  endif
else
  source ~/.vim/config/global.vim
  source ~/.vim/config/functions.vim
  source ~/.vim/config/keybindings.vim
  source ~/.vim/config/plugins_config.vim
  if filereadable(expand("~/.vim/config/vimrc_custom"))
    source ~/.vim/config/vimrc_custom
  endif
endif
