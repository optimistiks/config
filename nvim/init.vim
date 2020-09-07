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

	" Unified glyph colors
        Plug 'lambdalisue/glyph-palette.vim'

	" Fuzzy search
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

	" Statusline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" Git
	Plug 'tpope/vim-fugitive'
        Plug 'mhinz/vim-signify'
        Plug 'whiteinge/diffconflicts'

	" Utility
        Plug 'tpope/vim-repeat'
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-unimpaired'
        Plug 'mhinz/vim-startify'
	Plug 'jiangmiao/auto-pairs'
	Plug 'scrooloose/nerdcommenter'
        Plug 'ryanoasis/vim-devicons'

        call plug#end()

"PLUGINS>

"<CONFIG

        " Show line numbers in coc-explorer window
        autocmd FileType coc-explorer setlocal relativenumber

        " https://github.com/lambdalisue/glyph-palette.vim#usage
        augroup my-glyph-palette
          autocmd! *
          autocmd FileType coc-explorer,startify call glyph_palette#apply()
        augroup END

        " https://github.com/antoinemadec/FixCursorHold.nvim#configuration
        let g:cursorhold_updatetime = 100

        " When opening file from startify screen, set root to vcs root
        let g:startify_change_to_vcs_root = 1
       
        set clipboard=unnamedplus

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
	      \'coc-marketplace',
	      \'coc-explorer',
	      \'coc-actions',
	      \'coc-fzf-preview',
	      \'coc-html',
	      \'coc-css',
	      \'coc-tsserver',
	      \'coc-json',
	      \'coc-styled-components',
	      \'coc-eslint',
	      \'coc-prettier',
	      \]

  let g:fzf_preview_grep_cmd = 'rg --line-number --no-heading --color=never --fixed-strings'

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes

        " Give more space for displaying messages.
        set cmdheight=2

        " Don't pass messages to |ins-completion-menu|.
        set shortmess+=c

"COC>

"<SHORTCUTS

        " Remap leader key to Space
        map <Space> <Leader>
        map <Space><Space> <Leader><Leader>

        " Look for stuff

        " Quick open file
        noremap <F1> :CocCommand fzf-preview.GitFiles<CR>
	" Search text everywhere
        noremap <F2> :CocCommand fzf-preview.ProjectGrep<Space>

        " Go to stuff - fdsa

        " Go to definition
	map <Leader>f <Plug>(coc-definition)
        " Go to references
	map <Leader>d <Plug>(coc-references)
	" Go to implementation
	map <Leader>s <Plug>(coc-implementation)
	" Go to type definition
	map <Leader>a <Plug>(coc-type-definition)

        " Open stuff - zx

        " Toggle file explorer
        noremap <Leader>z :CocCommand explorer --position floating<CR>
        " Open list of diagnostics
        noremap <Leader>x :CocList diagnostics<CR>

        " Intelligent stuff - hjkl;
        
        " Show hover help
	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
	    execute 'h '.expand('<cword>')
	  else
	    call CocAction('doHover')
	  endif
	endfunction
	noremap <Leader>h :call <SID>show_documentation()<CR>
        " Actions menu for cursor position
        noremap <Leader>j :CocCommand actions.open<CR>
        " Show actions
        map <Leader>k <Plug>(coc-codeaction)
        " Rename
        map <Leader>l <Plug>(coc-rename)
        " Quick fix current problem
        map <Leader>; <Plug>(coc-fix-current)

        " Navigate stuff - ][, ';
        
        " Navigate diagnostics
        map <Leader>] <Plug>(coc-diagnostic-next)
        map <Leader>[ <Plug>(coc-diagnostic-prev)

        " Navigate buffers
        noremap <Leader>' :bnext<CR>
        noremap <Leader>; :bprev<CR>

"SHORTCUTS>
