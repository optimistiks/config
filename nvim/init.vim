"<PLUGINS

        call plug#begin(stdpath('data') . '/plugged')

        " https://github.com/lambdalisue/fern.vim#note
        Plug 'antoinemadec/FixCursorHold.nvim'

	" Intellisense engine
        Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Syntax highlight
        Plug 'sheerun/vim-polyglot'

	" Color theme
        Plug 'joshdick/onedark.vim'

	" File tree
        Plug 'lambdalisue/fern.vim'
        Plug 'lambdalisue/nerdfont.vim'
        Plug 'lambdalisue/glyph-palette.vim'
        Plug 'lambdalisue/fern-renderer-nerdfont.vim'
        Plug 'lambdalisue/fern-git-status.vim'
        Plug 'lambdalisue/fern-mapping-project-top.vim'

	" Fuzzy search
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" Statusline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" Git
	Plug 'tpope/vim-fugitive'
        Plug 'mhinz/vim-signify'
        Plug 'whiteinge/diffconflicts'

	" Utility
	Plug 'tpope/vim-surround'
        Plug 'tpope/vim-unimpaired'
        Plug 'yegappan/mru' 
	Plug 'jiangmiao/auto-pairs'
	Plug 'scrooloose/nerdcommenter'
        Plug 'mhinz/vim-startify'
        Plug 'ryanoasis/vim-devicons'

        call plug#end()

"PLUGINS>

"<CONFIG

        " https://github.com/lambdalisue/glyph-palette.vim#usage
        augroup my-glyph-palette
          autocmd! *
          autocmd FileType fern,startify call glyph_palette#apply()
        augroup END

        " https://github.com/lambdalisue/fern-renderer-nerdfont.vim#usage
        let g:fern#renderer = "nerdfont"

        " https://github.com/antoinemadec/FixCursorHold.nvim#configuration
        let g:cursorhold_updatetime = 100

        " When opening file from startify screen, set root to vcs root
        let g:startify_change_to_vcs_root = 1
        
        " Hint from https://github.com/HerringtonDarkholme/yats.vim
        set re=0 

        " Syntax fold
        set foldmethod=syntax

        " Do not fold on open
        set foldlevelstart=99

        " Set line numbers to relative
	set number relativenumber

        " Set indent size to 2 spaces
	set expandtab
	set shiftwidth=2
	set softtabstop=2

	" Consider all lines in file for syntax highlighting
	" https://github.com/styled-components/vim-styled-components#breaking-syntax-highlighting-in-very-long-files
	autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
	autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

        " NERDComment - add spaces after comment delimiters by default
        let g:NERDSpaceDelims = 1

        " Show hidden files in Fern by default
        let g:fern#default_hidden = 1

        " Airline

	let g:airline_theme='onedark'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#formatter = 'unique_tail'
        let g:airline_powerline_fonts = 1

        " Color scheme

        syntax on
	set termguicolors
	set background=dark
        let g:onedark_hide_endofbuffer = 1
        let g:onedark_terminal_italics = 1
        colorscheme onedark

        " https://github.com/ryanoasis/vim-devicons/wiki/Extra-Configuration
        let g:WebDevIconsOS = 'Darwin'

"CONFIG>


"<COC
        " https://github.com/neoclide/coc.nvim#example-vim-configuration

	" Extensions
	let g:coc_global_extensions = [
	      \'coc-json',
	      \'coc-tsserver',
	      \'coc-eslint',
	      \'coc-prettier',
	      \'coc-styled-components',
	      \'coc-actions',
	      \]

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes

"COC>

"<SHORTCUTS

        " Remap leader key to Space
        map <Space> <Leader>
        map <Space><Space> <Leader><Leader>

        " Quick open file
        noremap <F1> :GFiles<CR>

	" Search text everywhere
        noremap <F2> :Rg<Space>

        " Go to definition
	map <Leader>d <Plug>(coc-definition)
        " Go to references
	map <Leader>r <Plug>(coc-references)
	" Go to implementation
	map <Leader>i <Plug>(coc-implementation)
	" Go to type definition
	map <Leader>t <Plug>(coc-type-definition)

        " Show hover help
	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
	    execute 'h '.expand('<cword>')
	  else
	    call CocAction('doHover')
	  endif
	endfunction
        
	noremap <Leader>h :call <SID>show_documentation()<CR>

        " Quick fix current problem
        map <Leader>qf <Plug>(coc-fix-current)

        " Navigate diagnostics
        map <Leader>[d <Plug>(coc-diagnostic-prev)
        map <Leader>]d <Plug>(coc-diagnostic-next)
        
        " Toggle file tree
        map <Leader>t :Fern<Space>.<Space>-drawer<Space>-reveal=%<CR>

        " Actions menu for cursor position
        noremap <Leader>a :CocCommand<Space>actions.open<CR>

        " Show actions
        map <Leader>ca <Plug>(coc-codeaction)

        " Rename
        map <Leader>cr <Plug>(coc-rename)

        " Open list of diagnostics
        noremap <Leader>ld :CocList diagnostics<CR>

"SHORTCUTS>
