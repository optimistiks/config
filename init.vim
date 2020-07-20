" PLUGINS
call plug#begin(stdpath('data') . '/plugged') 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'easymotion/vim-easymotion'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'altercation/vim-colors-solarized'
call plug#end()
set background=dark
" COLOR SCHEME
syntax enable
colorscheme NeoSolarized
set termguicolors

" EASYMOTION 
" Set easymotion case-insensitive
let g:EasyMotion_smartcase = 1
" Set easymotion commands to trigger from one <Leader> press instead of default two
map <Leader> <Plug>(easymotion-prefix)
" On S keypress trigger easymotion search (any number of chars)
map S <Plug>(easymotion-sn)
" On s keypress trigger easymotion 2-character search
map s <Plug>(easymotion-s2)

