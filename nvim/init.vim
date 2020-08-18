"<PLUGINS

        call plug#begin(stdpath('data') . '/plugged')

	" Intellisense engine
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Syntax highlight
        Plug 'yuezk/vim-js'
	Plug 'HerringtonDarkholme/yats.vim'
        Plug 'styled-components/vim-styled-components', { 'branch': 'main'  }
        Plug 'maxmellon/vim-jsx-pretty'
        Plug 'hail2u/vim-css3-syntax'
	" Color theme
        Plug 'joshdick/onedark.vim'
	" File tree
	Plug 'preservim/nerdtree'
        Plug 'Xuyuanp/nerdtree-git-plugin'
	" Fuzzy search
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	" Statusline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	" Git
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'
        Plug 'whiteinge/diffconflicts'
	" Utility
        Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-surround'
        Plug 'tpope/vim-unimpaired'
        Plug 'yegappan/mru' 
	Plug 'jiangmiao/auto-pairs'
	Plug 'scrooloose/nerdcommenter'
        Plug 'yuttie/comfortable-motion.vim'

        call plug#end()

"PLUGINS>

"<CONFIG

        " Recommended https://github.com/HerringtonDarkholme/yats.vim
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

        " Css box-shadow and so on https://github.com/hail2u/vim-css3-syntax#highlighting-problems-on-vertical-align-box-shadow-and-others
        augroup VimCSS3Syntax
          autocmd!
          autocmd FileType css setlocal iskeyword+=-
        augroup END

        " Nerdcomment - add spaces after comment delimiters by default
        let g:NERDSpaceDelims = 1

        " Open automatically when vim is opened without arguments
        " https://github.com/preservim/nerdtree#how-can-i-open-a-nerdtree-automatically-when-vim-starts-up-if-no-files-were-specified
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

        " Set line numbers in NERDTree
        let NERDTreeShowLineNumbers=1

        " Auto-delete buffer when deleting file from NERDTree
        let NERDTreeAutoDeleteBuffer = 1

        " Remove some visual NERDTree clutter
        let NERDTreeMinimalUI = 1
        let NERDTreeDirArrows = 1        

        " Show hidden files by default
        let NERDTreeShowHidden = 1

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

"CONFIG>


"<COC

	" Extensions
	let g:coc_global_extensions = [
	      \'coc-html',
	      \'coc-css',
	      \'coc-tsserver',
	      \'coc-styled-components',
	      \'coc-json',
	      \'coc-eslint',
	      \'coc-prettier',
	      \'coc-actions',
	      \]

	" The following bits taken from https://github.com/neoclide/coc.nvim#example-vim-configuration

	" Give more space for displaying messages.
	set cmdheight=2
	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c
	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
	set updatetime=300
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
        
        " Toggle NerdTree
        noremap <Leader>n :NERDTree<CR>

        " Actions menu for cursor position
        noremap <Leader>a :CocCommand<Space>actions.open<CR>

        " Show actions
        map <Leader>ca <Plug>(coc-codeaction)

        " Rename
        map <Leader>cr <Plug>(coc-rename)

        " Open list of diagnostics
        noremap <Leader>ld :CocList diagnostics<CR>

"SHORTCUTS>
