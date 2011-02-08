if [ "$1" == "" ]; then
  echo "Usage: sh install <system>"
  echo "       <system> can be 'mac', 'linux' or 'windows'"
  exit 1
fi
echo '
fun! MySys()
  return "$1"
endfun
if MySys() == "windows"
  source ~/vimfiles/vimrc
else
  source ~/.vim/vimrc
endif
echo "Installed Mon's vim configuration successfully!"
