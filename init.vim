call plug#begin(stdpath('data') . '/plugged') 
Plug 'asvetliakov/vim-easymotion'
call plug#end()

let g:EasyMotion_smartcase = 1
map <Leader> <Plug>(easymotion-prefix)
map S <Plug>(easymotion-sn)
map s <Plug>(easymotion-s2)
