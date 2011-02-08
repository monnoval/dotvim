"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DelBlankLines()
  " delete all blank lines
  v/\S/d
  " no highlight please
  nohl
  " go back to position
  exec "i"
endfunction

