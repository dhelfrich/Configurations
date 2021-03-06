"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved 
  " Required:
  set runtimepath+=/home/daniel/.vim/bundle/neobundle.vim/
endif
"note: just switched to Neobundle and modified the following lines:
"   changed rtp line
"   neobundle begin/end
"   changed Plugin to NeoBundle
"   changed Vundle Plugin to NeoBundleFetch
   
"set nocompatible              " be iMproved, required
"filetype off

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
call neobundle#begin(expand('/home/daniel/.vim/bundle'))

" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#begin(path)


" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" let Vundle manage Vundle, required
" Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos

NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'junegunn/fzf'
"fuzzy finder - Requires L9
NeoBundle 'L9'
" NeoBundle 'FuzzyFinder'
" NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
" scripts not on GitHub
" git repos on your local machine (i.e. when working on your own plugin)

NeoBundle 'honza/vim-snippets'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
" NeoBundle 'garbas/vim-snipmate'
NeoBundle 'SirVer/ultisnips'
NeoBundleLazy 'Valloric/YouCompleteMe'
NeoBundleLazy 'Shougo/neocomplete.vim'

"SingleCompile
NeoBundle 'vim-scripts/SingleCompile'

"Syntastic
NeoBundle 'scrooloose/syntastic'

"Vim Surround
NeoBundle 'tpope/vim-surround'

"GHC mod
NeoBundle 'eagletmt/ghcmod-vim'

"vimproc - required for GHC-mod
NeoBundle 'Shougo/vimproc.vim', {
              \ 'build' : {
	      \     'unix' : 'make -f make_unix.mak',
	      \    },
	      \ }

"Haskell Completing
NeoBundle 'eagletmt/neco-ghc'

"Haskell
NeoBundle 'dag/vim2hs'
NeoBundle 'jpalardy/vim-slime'
"NeoBundle 'lukerandall/haskellmode-vim'
"NeoBundle 'bitc/vim-hdevtools'

NeoBundle 'godlygeek/tabular'
NeoBundle 'kien/ctrlp.vim'

"Auto close brackets
NeoBundle 'Raimondi/delimitMate'

NeoBundle 'vim-scripts/Vim-R-plugin'

"Latex
NeoBundle 'LaTeX-Box-Team/LaTeX-Box'

"Python Colors
NeoBundle 'hdima/python-syntax'

call neobundle#end()
filetype plugin indent on


" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

"Make c++ header files be recognized as cpp

let $PATH = $PATH . ':' . expand('~/.cabal/bin')

"indent settings
set expandtab
set shiftwidth=4
set softtabstop=4

"show numbers
set nu
"show fold columns
set foldcolumn=2
set cursorline
set cursorcolumn

"virtual editing
set ve=all

"show commands on the bottom
set showcmd

"highlight search

set hlsearch

if has('mouse')
  set mouse=a
endif


"Macros
"
let @c = 'gg"+yG'

"-----Plugin specific settings----- 
"Syntastic

map <silent> <Leader>e :Errors<CR>
map <Leader>s :SyntasticToggleMode<CR>
let g:syntastic_auto_loc_list=2

"SingleCompile

nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>
"specify compiler
"call SingleCompile#ChooseCompiler('filetype', 'compiler')
call SingleCompile#ChooseCompiler('python', 'python3')
call SingleCompile#SetCompilerTemplate('cpp','g++','GNU C++ Compiler','g++', '-std=c++0x -Wall -g -o $(FILE_TITLE)$' , './$(FILE_TITLE)$')

"flags for c++ to match ones from CSCI2270
"didn't work
"autocmd Filetype cpp nmap <buffer> <F9> :SCCompileAF -std=c++0x -Wall -g <CR>
"autocmd Filetype cpp nmap <buffer> <F10> :SCCompileRunAF <CR>

"To try to get snipmate working
" :set runtimepath+=~/.vim/bundle/vim-snipmate/after
let g:UltiSnipsExpandTrigger="<leader>a"
let g:UltiSnipsJumpForwardTrigger="<leader>a"
let g:UltiSnipsJumpBackwardTrigger="<leader>s"



function! Neocompletesettings()
"neocomplete
    NeoBundleSource neocomplete.vim
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent. Had to disable for delimitMate
    "imap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    "function! s:my_cr_function()
    "  return neocomplete#close_popup() . "\<CR>"
    "  " For no inserting <CR> key.
    "  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    "endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:neocomplete#force_omni_input_patterns.python =
    \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    NeoCompleteEnable
endfunction

"call Neocompletesettings()
let blacklistNeoComplete = ['c', 'cpp']
autocmd  BufNewFile,BufRead * if (index(blacklistNeoComplete, &ft) < 0) | call Neocompletesettings() | endif

" Ctrl-Space for completions. Heck Yeah!
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
        \ "\<lt>C-n>" :
        \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
        \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
        \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

"Python syntax
let python_highlight_all = 1


"FuzzyFinder maps

"nmap <leader>f :FufFile<CR>
"nmap <leader>b :FufBuffer<CR>
"nmap <leader>r :FufTag<CR>

"CTRL-P
nmap <leader>f :CtrlP<CR>
nmap <leader>r :CtrlPBuffer<CR>

"Haskell Specific
function! HaskellSettings()
    map <leader>in :GhcModInfo<cr>
    map <leader>t :GhcModType<cr>
    map <leader>T :GhcModTypeInsert<cr>
    map <leader>ch :GhcModCheck<cr>
    map <leader>li :GhcModLint<cr>
    map <leader>ex :GhcModExpand<cr>

    "nnoremap <buffer> <F1> :GhcModType<CR>
    "nnoremap <buffer> <silent> <F2> :GhcModTypeClear<CR>

    nnoremap <esc> :noh<return>:GhcModTypeClear<return><esc>

    hi ghcmodType guibg=Green guifg=White ctermbg=green ctermfg=black cterm=None
    let g:ghcmod_type_highlight = 'ghcmodType'
    setlocal ve=all shiftwidth=2 softtabstop=2  expandtab  omnifunc=necoghc#omnifunc
    

    call WSHighlight()
endfunction

"Jedi Vim

let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled=0



"For R
function! RSettings()
    vmap <Space> <Plug>RDSendSelection
    nmap <Space> <Plug>RDSendLine
    let vimrplugin_applescript=0
    let vimrplugin_vsplit=1
endfunction


function! WSHighlight()
    syn match BadWhiteSpace "^\\s*\\t\\+"
    syn match BadWhiteSpace "\\s\\+$"
endfunction

au BufNewFile,BufRead *.hs call HaskellSettings()
au BufNewFile,BufRead *.r call RSettings()

"let g:ycm_semantic_triggers = {'haskell' : ['.']}

"GHC-Mod
"nmap <leader>t :GhcModType<CR> 
"nmap <leader>T :GhcModType!<CR> 
"nmap <leader>y :GhcModTypeClear<CR> 

au FileType haskell nnoremap <buffer> <F1> :GhcModType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :GhcModTypeClear<CR>
au FileType haskell map <LocalLeader>in :GhcModInfo<cr>

"latex-box
let g:LatexBox_latexmk_options = "-bibtex"

"vim-hdevtools

"au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
"au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>

"Haskellmode-vim

"let g:haddock_browser="/usr/bin/google-chrome"

"Ctrl-p settings

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': '',
  \ }


"Vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()

"Color Scheme/GUI settings

if has('gui_running')
    set background=light
else
    set background=dark
endif

"DelimitMate



let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1

"YouCompleteMe just for c,cpp

"let blacklist = ['c', 'cpp']
"autocmd BufWritePre * if index(blacklist, &ft) < 0 | NeoBundleSource neocomplete 
autocmd FileType c,cpp NeoBundleSource YouCompleteMe
autocmd FileType c,cpp let g:ycm_confirm_extra_conf = 0

"more cpp settings
autocmd FileType c,cpp set foldmethod=syntax

"colorscheme settings
set t_Co=256
"colorscheme xoria256
"colorscheme molokai
"colorscheme wombat
colorscheme badwolf
