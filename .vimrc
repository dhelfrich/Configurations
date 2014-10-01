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
NeoBundle 'Valloric/YouCompleteMe'
" NeoBundle 'Shougo/neocomplete'

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


call neobundle#end()
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


"indent settings
set expandtab
set shiftwidth=4
set softtabstop=4

"show numbers
set nu
"show fold columns
set foldcolumn=2

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
let g:syntastic_auto_loc_list=1

"SingleCompile

nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>
"specify compiler
"call SingleCompile#ChooseCompiler('filetype', 'compiler')
call SingleCompile#ChooseCompiler('python', 'python3')

"flags for c++ to match ones from CSCI2270
"didn't work
"autocmd Filetype cpp nmap <buffer> <F9> :SCCompileAF -std=c++0x -Wall -g <CR>
"autocmd Filetype cpp nmap <buffer> <F10> :SCCompileRunAF <CR>

"To try to get snipmate working
" :set runtimepath+=~/.vim/bundle/vim-snipmate/after
let g:UltiSnipsExpandTrigger="<leader>a"
let g:UltiSnipsJumpForwardTrigger="<leader>a"
let g:UltiSnipsJumpBackwardTrigger="<leader>s"

"YouCompleteMe
let g:ycm_confirm_extra_conf = 0

"FuzzyFinder maps

"nmap <leader>f :FufFile<CR>
"nmap <leader>b :FufBuffer<CR>
"nmap <leader>r :FufTag<CR>

"CTRL-P
nmap <leader>f :CtrlP<CR>
nmap <leader>r :CtrlPBuffer<CR>



"Haskell Specific

autocmd FileType haskell setlocal shiftwidth=4 softtabstop=4  expandtab omnifunc=necoghc#omnifunc
let $PATH = $PATH . ':' . expand('~/.cabal/bin')
let g:ycm_semantic_triggers = {'haskell' : ['.']}

"GHC-Mod
"nmap <leader>t :GhcModType<CR> 
"nmap <leader>T :GhcModType!<CR> 
"nmap <leader>y :GhcModTypeClear<CR> 

au FileType haskell nnoremap <buffer> <F1> :GhcModType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :GhcModTypeClear<CR>
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


"colorscheme settings
set t_Co=256
"colorscheme xoria256
set background=dark
colorscheme molokai
