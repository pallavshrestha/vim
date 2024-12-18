"General settings
"
""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on
set tw=108
" set bg=light
set mouse=a
set ignorecase
set incsearch
set encoding=utf-8
" set clipboard=unnamedplus
set dir=/tmp
set autochdir "change pwd to the directory of the current file, sometimes it breaks then use lcd %:p:h
"autocmd BufEnter * silent! lcd %:p:h


set backspace=indent,eol,start
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent

colorscheme nord   "Color scheme
""""""""""""""""""""""""""""""


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
endif

call plug#begin()

Plug 'SirVer/ultisnips' "snippets engine

Plug 'honza/vim-snippets' "snippets

Plug 'lervag/vimtex' "Vim tex

Plug 'townk/vim-autoclose' "auto brackets, quotes

Plug 'tpope/vim-surround' "change surrounding brackets

Plug 'junegunn/vim-easy-align' "align gaip

Plug 'itchyny/lightline.vim'    "lightiline

Plug 'junegunn/fzf.vim'

Plug 'ycm-core/YouCompleteMe'  "fuzzy search and code completion

Plug 'anufrievroman/vim-angry-reviewer' "academic grammer review

Plug 'frazrepo/vim-rainbow' "rainbow paranthesis

Plug 'gabrielelana/vim-markdown'

Plug 'dense-analysis/ale' "Linting

Plug 'chrisbra/csv.vim'

Plug 'goerz/jupytext.vim' "open ipynb as markdown

Plug 'sillybun/vim-repl' "send code to repl for execution


call plug#end()
"""""""""""""""""""""""""""""



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


set laststatus=2
set noshowmode

let g:lightline = { 
                \ 'colorscheme': 'nord',
                \ 'active': {
      \   'right': [ ['lineinfo'] , ['percent'], ['wordcount'], ['fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'wordcount': 'WordCount',
      \ },
      \ }
"""""""""""""""""""""""""""""



"Bindings
"""""""""""""""""""""""""""""
" map ctrl+backspace to delete last word
"imap <C-BS> <C-w>
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" ultisnips
""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsEditSplit="vertical"
let g:snips_author = "pallav"
let g:snips_email = "shrestha.pallav@gmail.com"


" Vim Easy Align
""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Window Splits
""""""""""""""""""""
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


" vim-tex
""""""""""""""""""""
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
" set conceallevel=0
" let g:tex_conceal='abdmg'


" YouCompleteme
"""""""""""""""""""""""""""""
if !exists('g:ycm_semantic_triggers')
    let g:ycm_sematic_triggers = {}
endif 

 let g:ycm_semantic_triggers = {
        \ 'tex'  : ['{'],
        \ 'markdown'  : ['@'],
        \ 'pandoc' : ['@'],
        \ 'python' : ['.'],
    \}

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


" Semantec Highlight for ycm
"""""""""""""""""""'"""""""""
" call prop_type_add( 'YCM_HL_parameter', { 'highlight': 'Normal' } )

" let MY_YCM_HIGHLIGHT_GROUP = {
      " \   'typeParameter': 'PreProc',
      " \   'parameter': 'Normal',
      " \   'variable': 'Normal',
      " \   'property': 'Normal',
      " \   'enumMember': 'Normal',
      " \   'event': 'Special',
      " \   'member': 'Normal',
      " \   'method': 'Normal',
      " \   'class': 'Special',
      " \   'namespace': 'Special',
      " \ }

" for tokenType in keys( MY_YCM_HIGHLIGHT_GROUP )
  " call prop_type_add( 'YCM_HL_' . tokenType,
                    " \ { 'highlight': MY_YCM_HIGHLIGHT_GROUP[ tokenType ] } )
" endfor


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


" TOGGLE COMMENTS
""""""""""""""""""""""""""""""
autocmd FileType c,cpp,java,scala   let b:comment_leader = '//'
autocmd FileType javascript         let b:comment_leader = '//'
autocmd FileType solidity           let b:comment_leader = '//'
autocmd FileType sh,ruby,python     let b:comment_leader = '#'
autocmd FileType conf,fstab         let b:comment_leader = '#'
autocmd FileType i3config           let b:comment_leader = '#'
autocmd FileType tex,bib                let b:comment_leader = '%'
autocmd FileType mail               let b:comment_leader = '>'
autocmd FileType vim                let b:comment_leader = '"'
function! CommentToggle()
    execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
    execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction
map gcc :call CommentToggle()<CR>
""""""""""""""""""""""""""""""

" RAINBOW PARANTHESIS
""""""""""""""""""""""""""""""
au FileType c,python call rainbow#load()
let g:rainbow_ctermfgs = ['white', 'green', 'blue', 'yellow', 'magenta']
""""""""""""""""""""""""""""""
" https://gabri.me/blog/diy-vim-statusline "for diy statusline
"
" " CHANGE CURSOR DEPENDING ON THE MODE
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

""Temp binds for tmc
map <Leader>tt :w<cr> :!tmc test %<CR>
map <Leader>ts :w<cr> :!tmc submit %<CR>


autocmd FileType tex nnoremap <leader>cc :w<cr> :!pdflatex %:r.tex && bibtex %:r.aux && pdflatex %:r.tex && pdflatex %:r.tex && rm %:r.aux %:r.log %:r.blg %:r.bbl && notify-send -u low "LaTeX" "compilation is finished"<cr>
" map <leader>cm :w<cr> :!pandoc -s -f gfm -o %:r.pdf %:r.md --pdf-engine=xelatex -V geometry:margin=2cm<cr>
autocmd Filetype markdown nnoremap <leader>cm :w<cr> :!pandoc -o %:r.pdf %:r.md<cr>

" ale linting and fixing
""""""""""""""""""""""""""""""

let g:ale_linters = {'python': 'all'}
let g:ale_fixers = {'python': ['black','isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']}
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
set scl=no

""""""""""""""""""""""""""""""

"markdownrunner
""""""""""""""""""""""""""""""
" autocmd FileType markdown nnoremap <buffer> <Leader>r :MarkdownRunner<CR>
" autocmd FileType markdown nnoremap <buffer> <Leader>R :MarkdownRunnerInsert<CR>\
"
"

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

