"<PLUGINS

        call plug#begin(stdpath('data') . '/plugged')

	" Intellisense engine
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	" Syntax highlight
	" Order matters, to prevent an issue of vim-styled-components from happening
	" https://github.com/styled-components/vim-styled-components/issues/75
	Plug 'HerringtonDarkholme/yats.vim'
	Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
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
	Plug 'tpope/vim-surround'
        Plug 'tpope/vim-unimpaired'
        Plug 'easymotion/vim-easymotion'
	Plug 'jiangmiao/auto-pairs'
	Plug 'scrooloose/nerdcommenter'
        Plug 'yegappan/mru' 
        Plug 'yuttie/comfortable-motion.vim'
	
        call plug#end()

"PLUGINS>

"<CONFIG

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

        " Css syntax for properties with -
        " https://github.com/hail2u/vim-css3-syntax#highlighting-problems-on-vertical-align-box-shadow-and-others
        augroup VimCSS3Syntax
          autocmd!
          autocmd FileType css setlocal iskeyword+=-
        augroup END

"CONFIG>

"<SHORTCUTS

        " Custom shortcuts

        " Remap leader key to Space
        map <Space> <Leader>
        map <Space><Space> <Leader><Leader>
        
        " FZF bindings
        
        " Quick open file
        noremap <F1> :GFiles<CR>
        
	" Search text everywhere
        noremap <F2> :Rg<Space>

        " Easymotion bindings
        
        " Space-/ 2-char search
        map <Leader>/ <Plug>(easymotion-overwin-f2)
        
	" CoC bindings

        " d Go to definition
	map <Leader>d <Plug>(coc-definition)

        " r Go to references
	map <Leader>r <Plug>(coc-references)
	
	" i Go to implementation
	map <Leader>i <Plug>(coc-implementation)
	
	" t Go to type definition
	map <Leader>t <Plug>(coc-type-definition)

        " h Show help
	noremap <Leader>h :call <SID>show_documentation()<CR>

        " a Show actions
        map <Leader>a <Plug>(coc-codeaction)

        " f Fix current problem
        map <Leader>f <Plug>(coc-fix-current)

        " [ ] Navigate diagnostics
        map <Leader>[ <Plug>(coc-diagnostic-prev)
        map <Leader>] <Plug>(coc-diagnostic-next)

        " ld Open list of diagnostics
        noremap <Leader>ld :CocList diagnostics<CR>

        " cr Rename
        map <Leader>cr <Plug>(coc-rename)

"SHORTCUTS>

"<EASYMOTION

        " https://github.com/easymotion/vim-easymotion#minimal-configuration-tutorial
        
	" Disable default mappings
        let g:EasyMotion_do_mapping = 0
        
	" Turn on case-insensitive feature
        let g:EasyMotion_smartcase = 1

"EASYMOTION>

"<NERDTREE

        " Open automatically when vim is opened without arguments
        " https://github.com/preservim/nerdtree#how-can-i-open-a-nerdtree-automatically-when-vim-starts-up-if-no-files-were-specified
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
        
        " Set line numbers in NERDTree
        let NERDTreeShowLineNumbers=1
        autocmd FileType nerdtree setlocal relativenumber

        " Auto-delete buffer when deleting file from NERDTree
        let NERDTreeAutoDeleteBuffer = 1

        " Remove some visual NERDTree clutter
        let NERDTreeMinimalUI = 1
        let NERDTreeDirArrows = 1        

"NERDTREE>

"<AIRLINE

	let g:airline_theme='onedark'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#formatter = 'unique_tail'
        let g:airline_powerline_fonts = 1

"AIRLINE>

"<COLORS

	syntax on
	set termguicolors
	set background=dark
	let g:onedark_hide_endofbuffer=1
        let g:onedark_color_overrides = {
        \ "vertsplit": { "gui": "#2C323C", "cterm": "236", "cterm16": "8" }
        \}
        colorscheme onedark

"COLORS>

"<COC

	" Extensions
	let g:coc_global_extensions = [
	      \'coc-json',
	      \'coc-tsserver',
	      \'coc-eslint',
	      \'coc-prettier',
	      \'coc-styled-components'
	      \]

	" The following bits taken from https://github.com/neoclide/coc.nvim#example-vim-configuration
	
	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
	 set updatetime=300

	" Use gh to show documentation in preview window.
	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
	    execute 'h '.expand('<cword>')
	  else
	    call CocAction('doHover')
	  endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	if has("patch-8.1.1564")
	  " Recently vim can merge signcolumn and number column into one
	  set signcolumn=number
	else
	  set signcolumn=yes
	endif

"COC>