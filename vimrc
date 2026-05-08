" Basic configuration settings
""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible			    " use vim and not vi
filetype plugin on		    " load file-specific plugins
filetype indent on		    " load file-specific indentation
filetype on				        " enable filetype detection
" filetype plugin indent on 	" does the same thing?	
set encoding=utf-8
set wrap linebreak        " wrap long lines and break lines at words
set number				        " shows line numbers
set cursorline            " highlight current line
set ruler	  			        " shows cursor position in current line
set showcmd				        " shows partially typed commands
set ignorecase
set nohlsearch				    " don't highlight search results
set incsearch				    " don't jump to search results as search string is being typed
set noshowmode            " disable in favor of lightline.vim's statusline
set nofoldenable          " don't fold text by default when opening files
set autowriteall          " write current buffer when moving buffers
set clipboard=unnamedplus
syntax enable             " enable syntax highlighting

set dir=/tmp
set backupdir=~/.cache/vim/backup
set autochdir "change pwd to the directory of the current file, sometimes it breaks then use lcd %:p:h
"autocmd BufEnter * silent! lcd %:p:h

set backspace=indent,eol,start
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent

" disable automatic commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  

" set mouse=a
" let mapleader = " "
"""""""""""""""""""""""""""""""""""""""""""""

if (has("termguicolors"))
  " Force true color; see https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
  if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
  set background=dark
endif

colorscheme nord          " set colorscheme
hi Normal guibg=NONE ctermbg=NONE

"Auto line numbers
""""""""""""""""""""""""""""""
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
""""""""""""""""""""""""""""""

"Code folding
""""""""""""""""""""""""""""""
set foldmethod=indent
set foldnestmax=10
set foldlevel=5
nnoremap <space> za


"Plugins
""""""""""""""""""""""""""""""
if has('python3')
endif   "for times when it things there is no python.

" Specify plugins using Vim-Plug
call plug#begin('~/.vim/plugged')
" Global
Plug 'junegunn/vim-plug'
Plug 'itchyny/lightline.vim' "lightline
Plug 'SirVer/ultisnips'  "snippets engine:
Plug 'honza/vim-snippets'  "sinppets
Plug 'tpope/vim-commentary'  " commenting - gc, gcc, gcap
Plug 'junegunn/vim-easy-align' "align gaip
Plug 'junegunn/goyo.vim' "minimalism mode for focused writing
Plug 'junegunn/limelight.vim' "focused writing, grayscale, goes together with goyo
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive' "git stuff
Plug 'tpope/vim-git' "runtime for git
Plug 'tpope/vim-surround' "change surrounding brackets
Plug 'townk/vim-autoclose' "auto brackets, quotes
Plug 'ycm-core/YouCompleteMe'  "fuzzy search and code completion
Plug 'dense-analysis/ale' "Linting
Plug 'frazrepo/vim-rainbow' "rainbow paranthesis

" Filetype-specific
""""""""""""""""""""""""""""""
Plug 'chrisbra/csv.vim' "
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'lervag/vimtex'

Plug 'goerz/jupytext.vim' "open ipynb as markdown
Plug 'sillybun/vim-repl' "send code to repl for execution
Plug 'iamcco/markdown-preview.nvim' "markdown live preview in browser
Plug 'dhruvasagar/vim-table-mode' "table mode, mostly for markdown
Plug 'vim-pandoc/vim-pandoc' "markdown specific
Plug 'sotte/presenting.vim'

Plug 'anufrievroman/vim-angry-reviewer' "academic grammer review

Plug 'jasonccox/vim-wayland-clipboard'

Plug 'ledger/vim-ledger'

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""

" Runtimes
"""""""""""""""""""""""""""""
runtime markdown-preview.vim


" Copy Paste things
"""""""""""""""""""""""""""""

" Paste in visual mode without overwriting default register
vnoremap <silent> p "_d:call <SID>VisualPasteWithoutOverwrite()<CR>

function! s:VisualPasteWithoutOverwrite() abort
  " pastes with p for cursor on line end
  " pastes with P otherwise
  if col(".") + 1 == col("$")
    "actually there are special cases.
    " this is a hack but it covers my use cases nicely
    " problem: pasting while having selected the content of paired delimiters
    " at line end e.g. (some selected content)$ would result in
    " ()pasted content$ instead of (pasted content)$
    " so I check for e.g. ), }, ]
    let s:last_character_on_line = strpart(getline('.'), col('.') - 1, 1)
    if s:last_character_on_line == ')'
          \ || s:last_character_on_line == ']'
          \ || s:last_character_on_line == '}' 
          \ || s:last_character_on_line == '>' 
          \ || s:last_character_on_line == '"' 
          \ || s:last_character_on_line == "\'"
      normal P
    else
      normal p
    endif
  else
    normal P
  endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""
" END COPY-PASTE COMMANDS


" BEGIN NAVIGATION
"""""""""""""""""""""""""""""""""""""""""""""
" useful for jumping to end of nested snippets
" the silly jump to the line start via ^ is a hack to ensure cursor exits a possible UltiSnips snippet scope
" inoremap <C-L> <ESC>^$a

" cheating up and down
nnoremap j gj
nnoremap k gk

" navigate to line start and end from home row
" note that this overrides H and L to move the cursor to page top and page bottom
" noremap H g^
" noremap L g$

" Center cursor after various movements
noremap '' ''zz
noremap <C-O> <C-O>zz
noremap <C-I> <C-I>zz
noremap <C-]> <C-]>zz
noremap <C-D> <C-D>zz
noremap <C-U> <C-U>zz

" mappings for navigating buffers
noremap <leader>b :bnext<CR>
noremap <leader>B :bprevious<CR>
"""""""""""""""""""""""""""""""""""""""""""""
" END NAVIGATION


" Misc
"""""""""""""""""""""""""""""""""""""""""""""

map ctrl+backspace to delete last word
"imap <C-BS> <C-w>
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>


set splitbelow splitright

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>


" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" Start terminals for R and Python sessions '\tr' or '\tp'
"map <Leader>tp :new term://bash<CR>ipython3<CR><C-\><C-n><C-w>k
map <Leader>tr :term<CR>R<CR>
map <Leader>tp :term<CR>ipython<CR>

" python alias 
""""""""""""""""""""
" ,p runs python on script. ,t times python script
nmap ,P :w<CR>:!ipython -i %<CR>
nmap ,p :w<CR>:!python -i %<CR>
nmap ,t :w<CR>:!time python3 %<CR>
""""""""""""""""""""""""""""""

" bibtool sort

"""""""""""""""""""
"for bibtex
map <Leader>bts :!bibtool -s % -o %<CR>

"for bibtex
map <Leader>bls :!biber --tool % -outfile %<CR> 

" " CHANGE CURSOR DEPENDING ON THE MODE
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

""Temp binds for tmc
nmap ,tc :w<cr> :!tmc test %<CR>
nmap ,ts :w<cr> :!tmc submit %<CR>

" these are usually covered by other plugins, this is backup in case
" everything fails for bruteforcing or testing purpose

autocmd FileType tex nnoremap <leader>cc :w<cr> :!pdflatex -recorder %:r.tex && bibtex %:r.aux && pdflatex %:r.tex && pdflatex %:r.tex && rm %:r.aux %:r.log %:r.blg %:r.bbl && notify-send -u low "LaTeX" "compilation is finished"<cr>
" map <leader>cm :w<cr> :!pandoc -s -f gfm -o %:r.pdf %:r.md --pdf-engine=xelatex -V geometry:margin=2cm<cr>
autocmd Filetype markdown nnoremap <leader>cm :w<cr> :!pandoc -o %:r.pdf %:r.md<cr>

" https://gabri.me/blog/diy-vim-statusline "for diy statusline

" End Misc
"""""""""""""""""""""""""""""""""""""""""""""


inoremap <expr> <BS> <SID>DeletePairedDelimeter()
function! s:DeletePairedDelimeter() abort
  " adapted from https://vi.stackexchange.com/a/24763

  " First checks if the cursor as at line start or line end
  " ...For reasons I haven't figured out, adding these separate cases
  " ...fixes a problem with the original solution, which would
  " ...delete the first character in a line when typing <BS> at line start
  " ...or move the line below up when when typing <BS> at line start
  if col(".") == col("^") + 1 || col(".") == col("$")
    return "\<BS>"
  else
    " get characters on either side of cursor
    let pair = getline('.')[col('.')-2 : col('.')-1]
    echom pair
    " check if cursor is placed inside a paired delimeter
    if stridx('""''''()[]<>{}``', pair) % 2 == 0
      " deletes paired delimiter
      return "\<Right>\<BS>\<BS>"
    else  " cursor was not between paired delimiters
      " normal functionality
      return "\<BS>"
    endif
  endif
endfunction



" BEGIN PLUGIN CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""
" Disable vim-dispatch's default key mappings
let g:dispatch_no_maps = 1

" Disable csv.vim's key bindings
let g:no_csv_maps = 1

" ultisnips
""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsEditSplit="vertical"
let g:snips_author = "pallav"
let g:snips_email = "pallav.shrestha@ik.me"



"Lightline
"""""""""""""""""""""""""""""
" word count
""""""""""""""""""""""""""""""
let g:word_count=wordcount().words
function WordCount()
    if has_key(wordcount(),'visual_words')
        let g:word_count=wordcount().visual_words.":".wordcount().words " count selected words
    else
        let g:word_count=wordcount().cursor_words.":".wordcount().words " or shows words 'so far'
    endif
    return g:word_count
endfunction

" Hide file format for window widths below 70 cols
function! LightlineFileFormat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

" Hide file encoding for window widths below 70 cols
function! LightlineFileEncoding()
  return winwidth(0) > 70 ? &fileencoding : ''
endfunction

" Hide file type for window widths below 60 cols
function! LightlineFiletype()
  return winwidth(0) > 60 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction


set laststatus=2
set noshowmode

let g:lightline = { 
                \ 'colorscheme': 'nord',
                \ 'active': {
      \   'right': [ ['lineinfo'] , ['percent'], ['wordcount'], ['fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \ 'wordcount': 'WordCount',
      \ 'fileformat': 'LightlineFileFormat', 
      \ 'fileencoding': 'LightlineFileEncoding', 
      \ 'filetype': 'LighgtlineFileType',
      \ },
      \ }
"""""""""""""""""""""""""""""


" easy-align
""""""""""""""""""""

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" vim-tex
""""""""""""""""""""
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'


" YouCompleteme
"""""""""""""""""""""""""""""
if !exists('g:ycm_semantic_triggers')
    let g:ycm_sematic_triggers = {}
endif 

 let g:ycm_semantic_triggers = {
        \ 'tex'  : ['{'],
        "\ 'markdown'  : ['@'],
        \ 'pandoc' : ['@'],
        \ 'python' : ['.'],
    \}
 let g:ycm_semantic_triggers.pandoc = ['@']

  let g:ycm_filetype_blacklist = {}
 " let g:ycm_filetype_whitelist = {
         " \ 'text': 1,
         " \ 'markdown': 1,
         " \ 'notes': 1,
         " \ 'tex': 1,
         " \ 'python': 1,
         " \}
let g:ycm_python_binary_path='/home/pallav/conda/bin/python'
let g:ycm_python_interpreter_path='/home/pallav/conda/bin/python'
let g:ycm_enable_semantic_highlighting=1
let g:ycm_key_invoke_completion = '<C-Space>'
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_clear_inlay_hints_in_insert_mode=1
let g:ycm_enable_inlay_hints=1
let g:ycm_disable_signature_help = 0 
imap <silent> <C-l> <Plug>(YCMToggleSignatureHelp)
nnoremap <silent> <localleader>h <Plug>(YCMToggleInlayHints)
" let g:SuperTabClosePreviewOnPopupClose = 1
""

" Clean auxillary files on exit
"""""""""""""""""""""""""""""""
augroup vimtex_config
   au!
   au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END


"Fix pumvisible on autoclose ()
""""""""""""""""""""""""""""""
 let g:AutoClosePreserveDotReg = 0



"Angry Reviewer
""""""""""""""""""""""""""""""
let g:AngryReviewerEnglish='british' "'british'
nnoremap <leader>ar :AngryReviewer<cr>

" QUICK-FIX WINDOW
nmap <silent> <leader>n  :cnext<cr>
nmap <silent> <leader>p  :cprev<cr>
nmap <silent> <leader>o  :copen<cr>
nmap <silent> <leader>q  :cclose<cr>
""""""""""""""""""""""""""""""


" TOGGLE COMMENTS    "covered by vim-comment
" """"""""""""""""""""""""""""""
" autocmd FileType c,cpp,java,scala   let b:comment_leader = '//'
" autocmd FileType javascript         let b:comment_leader = '//'
" autocmd FileType solidity           let b:comment_leader = '//'
" autocmd FileType sh,ruby,python     let b:comment_leader = '#'
" autocmd FileType conf,fstab         let b:comment_leader = '#'
" autocmd FileType i3config           let b:comment_leader = '#'
" autocmd FileType tex,bib            let b:comment_leader = '%'
" autocmd FileType mail               let b:comment_leader = '>'
" autocmd FileType vim                let b:comment_leader = '"'
" autocmd FileType markdown           let b:comment_leader = '[//]: #'
" function! CommentToggle()
"     execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
"     execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
" endfunction
" map gcc :call CommentToggle()<CR>
""""""""""""""""""""""""""""""

" RAINBOW PARANTHESIS
""""""""""""""""""""""""""""""
au FileType c,python call rainbow#load()
let g:rainbow_ctermfgs = ['white', 'green', 'blue', 'yellow', 'magenta']
""""""""""""""""""""""""""""""

" ale linting and fixing
""""""""""""""""""""""""""""""

let g:ale_linters = {'python': 'all', 'tex': ['chktex', 'lacheck']}
let g:ale_fixers = {'python': ['black','isort', 'remove_trailing_lines', 'trim_whitespace']}
let g:ale_lsp_suggestions = 1
let g:ale_fix_on_save = 1
let g:ale_go_gofmt_options = '-s'
let g:ale_go_gometalinter_options = '— enable=gosimple — enable=staticcheck'
let g:ale_completion_enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %code: %%s'
let g:ale_completion_enabled = 0
let g:ale_tex_chktex_options = '-n24; -n36' 
let g:ale_python_black_options = '--line-length=88'
" let g:ale_python_flake8_options = '--ignore E501'
let g:ale_python_pylint_options = '--rcfile ~/.config/pylint.rc' " --disable=C0301' "='line-too-long'
set scl=no

" let g:ale_lsp_auto_enable =1 

  " call ale#linter#Define('tex', {
  " \   'name': 'harper',
  " \   'lsp': 'stdio',
  " \   'executable': '/usr/sbin/harper-ls',
  " \   'command': '%e --stdio',
  "  \   'project_root': '$HOME/work/articles/article2'
  \})

  " call ale#linter#Define('tex', {
  " \   'name': 'harper_sock',
  " \   'lsp': 'socket',
  " \   'address': '127.0.0.1:4000',
  "  \   'project_root': '$HOME/work/articles/article2'
  " \})
" nmap <silent> K <Plug>(ale_hover)
" nmap <silent> <leader>e <Plug>(ale_show_diagnostics)

" vimREPL
""""""""""""""""""""""""""""""
let g:repl_program = {
            \   'python': 'ipython',
            \   'markdown': 'ipython',
            \   'default': 'bash',
            \   'r': 'R',
            \   'lua': 'lua',
            \   'vim': 'vim -e',
            \   }
let g:repl_predefine_python = {
            \   'numpy': 'import numpy as np',
            \   'matplotlib': 'from matplotlib import pyplot as plt'
            \   }
let g:repl_code_block_fences = {'python': '### Start', 'zsh': '# %%', 'markdown': '```'}
let g:repl_code_block_fences_end = {'python': '### End', 'zsh': '# %%', 'markdown': '```'}
let g:repl_sendvariable_template = {
            \ 'python': 'print(<input>)',
            \ 'ipython': 'print(<input>)',
            \ 'ptpython': 'print(<input>)',
            \ }

let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_ipython_version = '7'
let g:repl_output_copy_to_register = "t"
nnoremap <leader>r :REPLToggle<Cr>
nnoremap <leader>e :REPLSendSession<Cr>
let g:sendtorepl_invoke_key = "<leader>w"
let g:repl_console_name = 'ZYTREPL'
let g:repl_position = 3
let g:repl_python_auto_send_unfinish_line = 1

" figlet for presenting 
""""""""""""""""""""""""""""""
let g:presenting_figlets = 0


" Vim Pandoc
""""""""""""""""""""""""""""""
let g:pandoc#modules#disabled = ["folding"]
" let g:pandoc#biblio#use_bibtool = 1 "doesn't work so disabled
" let g:pandoc#biblio#sources = ["bcy"]
"
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#modules#enabled = ["bibliographies", "completion"]

" Goyo and Limelight for focused writing
"""""""""""""""""""""""""""""""""""""""""""""
" Integration of limelight with goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:goyo_width=110 "defualt goyo width


" Csv,vim
"""""""""""""""""""""""""""""""""""""""""""""
let g:csv_delim_test = ',;|'


" wayland clipboard
"""""""""""""""""""""""""""""""""""""""""""""
" let g:wayland_clipboard_no_plus_to_w = 1
"""""""""""""""""""""""""""""""""""""""""""""

" ledger
"""""""""""""""""""""""""""""""""""""""""""""
  let g:ledger_maxwidth = 80
  let g:ledger_fillstring = '    -'
  let g:ledger_detailed_first = 1
  let g:ledger_fuzzy_account_completion = 1
  let g:ledger_fold_blanks = 0

" END PLUGIN CONFIGURATION
