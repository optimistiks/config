"<PLUGINS

        call plug#begin(stdpath('data') . '/plugged')
        
        Plug 'easymotion/vim-easymotion'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'morhetz/gruvbox'
        
        call plug#end()

"PLUGINS>

"<EASYMOTION 

        " Set easymotion case-insensitive
        let g:EasyMotion_smartcase = 1

        " Set easymotion commands to trigger from one <Leader> press instead of default two
        map <Leader> <Plug>(easymotion-prefix)

        " On S keypress trigger easymotion search (any number of chars)
        map S <Plug>(easymotion-sn)

        " On s keypress trigger easymotion 2-character search
        map s <Plug>(easymotion-s2)

"EASYMOTION>

"<COLORS

        colorscheme gruvbox
        set background=dark

"COLORS>


