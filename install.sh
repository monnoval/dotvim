if [ "$1" == "" ]; then
  echo "Usage: sh install.sh <system>"
  echo "       <system> can be 'mac', 'linux' or 'windows'"
  exit 1
fi
if [ "$1" == "windows" ] || [ "$1" == "win" ]; then
  echo 'fun! MySys()
  return "windows"
endfun
source ~/vimfiles/vimrc' > ~/_vimrc
elif [ "$1" == "linux" ] || [ "$1" == "lin" ]; then
  echo 'fun! MySys()
  return "linux"
endfun
source ~/.vim/vimrc' > ~/.vimrc
elif [ "$1" == "mac" ]; then
  echo 'fun! MySys()
  return "mac"
endfun
source ~/.vim/vimrc' > ~/.vimrc
fi
echo "Successfully installed Mon's vim config. Enjoy!"
