"set nocompatible              " be iMproved, required
"filetype off                  " required
"
"" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"" alternatively, pass a path where Vundle should install plugins
""call vundle#begin('~/some/path/here')
"
"" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Lokaltog/vim-powerline'
"Plugin 'scrooloose/nerdtree'
"Plugin 'Yggdroot/indentLine'
"Plugin 'majutsushi/tagbar'
"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" " plugin on GitHub repo
"" Plugin 'tpope/vim-fugitive'
"" " plugin from http://vim-scripts.org/vim/scripts.html
"" Plugin 'L9'
"" " Git plugin not hosted on GitHub
"" Plugin 'git://git.wincent.com/command-t.git'
"" " git repos on your local machine (i.e. when working on your own plugin)
"" Plugin 'file:///home/gmarik/path/to/plugin'
"" " The sparkup vim script is in a subdirectory of this repo called vim.
"" " Pass the path to set the runtimepath properly.
"" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" " Install L9 and avoid a Naming conflict if you've already installed a
"" " different version somewhere else.
"" Plugin 'ascenator/L9', {'name': 'newL9'}
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" set the mouse on when in GUI or in xterm
set mouse=a

" Configuration file for vim

set modelines=0 " CVE-2007-2438
" Normally we use vim-extensions. If you want true vi-compatibility

" remove change the following statements

set nocompatible " Use Vim defaults instead of 100% vi compatibility

set backspace=2 " more powerful backspacing
syntax on

" 语法高亮
set vb t_vb=
" 去掉输入错误的提示声音
autocmd InsertLeave * se nocul

autocmd InsertEnter * se cul

" 用浅色高亮当前行
set smartindent

" 智能对齐
set autoindent

" 自动对齐
set confirm

" 在处理未保存或只读文件的时候，弹出确认
set tabstop=4

" Tab键的宽度
set softtabstop=4

set shiftwidth=4

"   统一缩进为4

set number

" 显示行号
set history=50

" 历史纪录数
set hlsearch

set incsearch

" 搜索逐字符高亮
set gdefault

" 行内替换
set encoding=utf-8

set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,utf-16,big5,euc-jp,latin1

" 编码设置
colorscheme desert

" 设置颜色主题
set guifont=Menlo:h16:cANSI

" 设置字体
set langmenu=zn_CN.UTF-8

set helplang=cn

" 语言设置
set cmdheight=2

" 命令行（在状态行）的高度，默认为1,这里是2
set ruler

" 在编辑过程中，在右下角显示光标位置的状态行
set laststatus=2

" 总是显示状态行
set showcmd

" 在状态行显示目前所执行的命令，未完成的指令片段亦会显示出来
set scrolloff=3

" 光标移动到buffer的顶部和底部时保持3行距离
set showmatch

" 高亮显示对应的括号
set matchtime=5

" 对应括号高亮的时间（单位是十分之一秒）

map <F7> :if exists("syntax_on") <BAR>
\    syntax off <BAR><CR>
\  else <BAR>
\syntax enable <BAR>
\  endif <CR>
" 单键<F7>控制syntax on/off。原因是有时候颜色太多会妨碍阅读。

func! CompileGcc()
    exec "w"
let &mp="gcc % -o %< "
make
endfunc
func! CompileGpp()
exec "w"
let &mp="g++ % -std=c++11 -Wall -O2 -o %< "
make
endfunc

func! RunPython()
exec "w"
exec "!python3 %"
endfunc
func! CompileJava()
exec "w"
let &mp="javac %"
make
endfunc
func! RunShell()
exec "w"
exec "sudo chmod 777 %" 
exec "!./%"
endfunc

func! CompileCode()
exec "w"
if &filetype == "cpp"
	exec "call CompileGpp()"
elseif &filetype == "c"
	exec "call CompileGcc()"
elseif &filetype == "python"
	exec "call RunPython()"
elseif &filetype == "java"
	exec "call CompileJava()"
elseif &filetype == "sh"
	exec "call RunShell()" 
endif
endfunc

func! RunResult()
exec "w"
if search("mpi\.h") != 0
	exec "!mpirun -np 4 ./%<"
elseif &filetype == "cpp"
	exec "! ./%<"
elseif &filetype == "c"
	exec "! ./%<"
elseif &filetype == "python"
	exec "call RunPython()"
elseif &filetype == "java"
	exec "!java %<"
elseif &filetype == "sh" 
	exec "call RunShell()"
endif
endfunc

map <F5> :call CompileCode()<CR>
imap <F5> <ESC>:call CompileCode()<CR>
vmap <F5> <ESC>:call CompileCode()<CR>

map <F6> :call RunResult()<CR>
" <F6>保存与编译C++程序
" <F5>运行C++程序

"<F8>tagbar
nmap<F8> :TagbarToggle<CR>




" #####YouCompleteMe Configure 
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"" 自动补全配置
"set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
""inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	
""回车即选中当前项
""上下左右键的行为 会显示其他信息
"inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
"inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
"inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
"inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
"
""youcompleteme  默认tab  s-tab 和自动补全冲突
""let g:ycm_key_list_select_completion=['<c-n>']
""let g:ycm_key_list_select_completion = ['<Down>']
""let g:ycm_key_list_previous_completion=['<c-p>']
""let g:ycm_key_list_previous_completion = ['<Up>']
"let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
"
"let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
"let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
"let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
"let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
""nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
""nnoremap <leader>lo :lopen<CR>	"open locationlist
""nnoremap <leader>lc :lclose<CR>	"close locationlist
""inoremap <leader><leader> <C-x><C-o>
""在注释输入中也能补全
"let g:ycm_complete_in_comments = 1
""在字符串输入中也能补全
"let g:ycm_complete_in_strings = 1
""注释和字符串中的文字也会被收入补全
"let g:ycm_collect_identifiers_from_comments_and_strings = 0
"let g:clang_user_options='|| exit 0'
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
"let g:ycm_autoclose_preview_window_after_completion = 1
"" 补全后自动关闭预览窗口
"" #####YouCompleteMe Configure 
"" setting for tmux
"if exists('$TMUX')
"  set term=screen-256color
"endif
"
""NERDTree 相关配置
""F2开启和关闭树"
"map <F2> :NERDTreeToggle<CR>
"let NERDTreeDirMode = 1
""显示书签
"let NERDTreeShowBookmarks = 1
""设置忽略文件类型"
"let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
""窗口大小"
"let NERDTreeWinSize=25
"
""indentLine 相关配置
""缩进指示线"
"let g:indentLine_char='┆'
"let g:indentLine_enabled = 1
"
"" Tagbar
"let g:tagbat_ctags_bin='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
"let g:tagbar_autofocus=1
"nmap <F3> :TagbarToggle<CR>
