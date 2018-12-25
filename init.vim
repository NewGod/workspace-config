let g:python_host_prog='/usr/bin/python3'

set nocompatible
filetype off

call plug#begin("~/.config/nvim/bundle")
" Plugin List
Plug 'rking/ag.vim'
Plug 'Yggdroot/indentLine'
Plug 'Valloric/MatchTagAlways'
Plug 'bigeagle/molokai'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'

Plug 'majutsushi/tagbar'
Plug 'jrosiek/vim-mark'
Plug 'kien/rainbow_parentheses.vim'

Plug 'mattn/emmet-vim'
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'zaiste/tmux.vim'
Plug 'lepture/vim-jinja'
Plug 'cespare/vim-toml'
Plug 'isRuslan/vim-es6'
" Plug 'elzr/vim-json'

Plug 'w0rp/ale'
Plug 'junegunn/fzf'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/echodoc.vim'
Plug 'davidhalter/jedi-vim'


call plug#end()

" UI
if !exists("g:vimrc_loaded")
"	if has("nvim")
"		set termguicolors
"	endif
	let g:molokai_original = 1
	colorscheme molokai
endif " exists(...)

set so=10
set number
syntax on
filetype on
filetype plugin on
filetype indent on

set list lcs=tab:\¦\   

if has("autocmd")  " go back to where you exited
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

set completeopt=longest,menu " preview

if has('mouse')
    set mouse=a
    set selectmode=mouse,key
    set nomousehide
endif

set autoindent
set modeline
set cursorline
set cursorcolumn

set shiftwidth=4
set tabstop=4
set softtabstop=4

set showmatch
set matchtime=0
set nobackup
set nowritebackup
set directory=/tmp/.swapfiles//

if has('nvim')
   set ttimeout
   set ttimeoutlen=0
endif

"在insert模式下能用删除键进行删除
set backspace=indent,eol,start

set fenc=utf-8
set fencs=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set enc=utf-8

"按缩进或手动折叠
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
set foldcolumn=0 "设置折叠区域的宽度
set foldlevelstart=200
set foldlevel=200  " disable auto folding
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <Space> zf

set smartcase
set ignorecase
set nohlsearch
set incsearch
set autochdir

vmap j gj
vmap k gk
nmap j gj
nmap k gk

nmap T :tabnew<cr>

au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap  <buffer>  {<CR> {<CR>}<Esc>O

au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()

function ScriptHeader()
    if &filetype == 'python'
        let header = "#!/usr/bin/python3"
        let cfg = "# vim: ts=4 sw=4 sts=4 expandtab"
    elseif &filetype == 'sh'
        let header = "#!/bin/bash"
    endif
    let line = getline(1)
    if line == header
        return
    endif
    normal m'
    call append(0,header)
    if &filetype == 'python'
        call append(2, cfg)
    endif
    normal ''
endfunction

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

nmap t<Enter> :bo sp term://zsh\|resize 5<CR>i
" --- Plugin Configs ---------
let g:tagbar_width = 30
nmap tb :TagbarToggle<cr>

let g:localvimrc_ask=0
let g:localvimrc_sandbox=0

let g:vim_json_syntax_conceal = 0
let g:indentLine_noConcealCursor=""

" - Airline -------------------
set noshowmode
set laststatus=2
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0
" ----------------------------

" Deoplete and echodoc
set noshowmode
let g:echodoc#enable_at_startup = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'
let g:deoplete#sources#jedi#extra_path = split($PYTHONPATH, ":")

let g:deoplete#sources = {}
let g:deoplete#sources.python = ['jedi']
 
inoremap <silent><expr> <C-x><C-o> deoplete#mappings#manual_complete("jedi")
inoremap <expr> <C-o> pumvisible() ? "\<C-n>" : "\<C-o>"
" ----------------------------

" - NerdTree -----------------
nmap nt :NERDTreeToggle<cr>
let NERDTreeShowBookmarks=0
let NERDTreeMouseMode=2

let NERDTreeWinSize=25
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeMinimalUI=0
let NERDTreeDirArrows=1
" ----------------------------

" - python and jedi ----------
let python_highlight_all = 1
autocmd BufWritePre *.py :%s/\s\+$//e
au FileType python setlocal cc=80

let g:jedi#force_py_version=3
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = ""
let g:jedi#rename_command = "<leader>r"
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#usages_command = "<leader>u"
let g:jedi#show_call_signatures_delay = 100
let g:jedi#completions_enabled = 0
" ----------------------------

" - rainbow_parentheses ------
let g:rbpt_colorpairs = [
	\ [158, '#00ceb3'],
	\ [081, '#00a3ff'],
	\ [214, '#ff8d00'],
	\ [123, '#3fffc9'],
	\ [045, '#29b9ec'],
	\ [190, '#bfec29'],
	\ [208, '#ffad00'],
	\ [117, '#48bde0'],
	\ ]

let g:rbpt_max = 8
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax c,cpp,go,h,java,python,javascript,scala,coffee RainbowParenthesesLoadSquare
au Syntax c,cpp,go,h,java,python,javascript,scala,coffee,scss  RainbowParenthesesLoadBraces
" ----------------------------

" - ALE ---------------------
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1

let g:airline#extensions#ale#enabled = 1

let g:ale_linters = {
\   'python': ['flake8'],
\}

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_python_flake8_options = "--ignore=E501,F401,E226,E741"
" ---------------------------

" Load local config if exists
if filereadable(expand("~/.config/nvim/local.vim"))
	source ~/.vim/config/local.vim
endif
