"判断平台-------------------------------------
function! MySys()
	if has("win32")||has("win64")
		return "windows"
	elseif has("mac")
        return "mac"
    else
		return "linux"
	endif
endfunction
"----------------------------------------------

"基本设置--------------------------------------
"分割窗口时保持相等的宽/高
set equalalways 
"选择颜色方案
colorscheme desert
"禁用Vi的兼容模式
set nocompatible 
"自动显示行号
set number
"一个tab键所跨过的空格数，通常为4
set tabstop=4
"当行之间交错时使用4个空格
set shiftwidth=4
"不使用Tab缩进
set expandtab
"设置匹配模式
set showmatch
"去掉错误警告时的提示音
set vb t_vb= 
"动态匹配查找的字符
set incsearch
"自动对齐
set autoindent
"智能对齐
set smartindent
"在右下角显示当前光标的位置
set ruler
"高亮显示匹配的字符
set hlsearch
"历史记录的行数
set history=1000
"在插入模式下，允许<BS>删除光标前的字符。逗号分隔的三个值分别指：行首的空白字符，换行符和插入模式开始之前的字符
set backspace=indent,eol,start
"语法高亮
syntax on
"关闭备份
set nobackup
"显示右下角命令
set showcmd
"自动判断编码时，依次尝试
set fileencodings=utf-8,gb18030,gbk,gb2312,big5,ucs-bom,default,latin1
"输出到终端编码
set termencoding=utf-8 
"vim内部使用的编码方式，缓冲区、编辑的文件、脚本文件
set encoding=utf-8
"新文件和正在编辑文件的编码，如果为空和encoding相同
set fileencoding=utf8
"-----------------------------------------------------------------------

"自动记忆上一次文件打开的位置-------------------------------------------
if has("autocmd")
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")| exe "normal! g`\"" | endif
endif
"-----------------------------------------------------------------------
" 编辑vimrc之后，重新加载-----------------------------------------------
if MySys() == "windows"
	autocmd! bufwritepost _vimrc source ~/_vimrc
else
	autocmd! bufwritepost .vimrc source ~/.vimrc
endif
"-----------------------------------------------------------------------

"Bundle插件设置----------------------------------------
filetype off	" required!
set rtp+=~/.vim/vundle/
"set rtp+=~/.vim/bundle/vundle/,~/.vim/doc/
call vundle#rc()

" let Vundle manage Vundle
" required!

Bundle 'https://github.com/gmarik/vundle.git'

" My Bundles here:
"
" original repos on github

"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup',{'rtp':'vim/'}
"Bundle 'tpope/vim-rails.git'

" vim-scripts repos
"Bundle 'doc'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'https://github.com/vim-scripts/taglist.vim.git'
Bundle 'Markdown'
Bundle 'c.vim'
Bundle 'python.vim'
Bundle 'go.vim'
"Bundle 'Tasklist.vim'
"Bundle 'vimwiki'
Bundle 'The-NERD-Commenter'
Bundle 'The-NERD-tree'
"Bundle 'vim_django'
Bundle 'minibufexpl.vim'
Bundle 'Pydiction'
Bundle 'snipMate'
"Bundle 'superSnipMate'
Bundle 'django.vim'
Bundle 'vim-flake8'
"Bundle 'VimRepress'
"Bundle 'FencView.vim'
"Bundle 'pyflakes.vim'
"Bundle 'xptemplate'

" non github repos
"
"Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on " required!
"---------------------------------------------------------------

"Pydiction自动补全-------------------
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
let g:pydiction_menu_height = 20
"------------------------------------

"映射按键指定文件类型----------------
:map <C-1> :set syntax=python
:map <C-2> :set syntax=xhtml
"------------------------------------

"文件类型设定---------------------------------------------------------
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.py,*pyw set filetype=python
autocmd FileType python setlocal expandtab textwidth=79 
"autocmd FileType python setlocal expandtab colorcolumn=79 textwidth=79 
"autocmd FileType asciidoc setlocal colorcolumn=79
"autocmd FileType markdown setlocal colorcolumn=79
"autocmd FileType mako setlocal colorcolumn=79 cc=0 fdm=indent
"autocmd FileType html setlocal shiftwidth=2 tabstop=2
"autocmd FileType haskell setlocal expandtab
"autocmd FileType lua setlocal expandtab
"autocmd FileType java setlocal colorcolumn=108
"autocmd FileType ruby setlocal expandtab shiftwidth=2 colorcolumn=79
"autocmd FileType eruby setlocal expandtab shiftfdswidth=2
"autocmd FileType rst setlocal colorcolumn=79
"-------------------------------------------------------------------------

"映射 F5 to Run Python Script--------------------------------------------
autocmd FileType python map <F5> :!python %
autocmd FileType python map <C-F5> :!python -m pdb %
autocmd FileType python map <F6> :!python2 %
autocmd FileType python map <C-F6> :!python2 -m pdb %
"-------------------------------------------------------------------------

"fcitx输入法设定
let g:input_toggle = 1
function! Fcitx2en()
    let s:input_status = system("fcitx-remote")
    if s:input_status == 2
        let g:input_toggle = 1
        let l:a = system("fcitx-remote -c")
    endif
endfunction

function! Fcitx2zh()
    let s:input_status = system("fcitx-remote")
    if s:input_status != 2 && g:input_toggle == 1
        let l:a = system("fcitx-remote -o")
        let g:input_toggle = 0
    endif
endfunction
set timeoutlen=150
autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2zh()
"----------------------

"minibufexpl插件设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 
"---------------------------
" 如遇Unicode值大于255的文本，不必等到空格再折行。
set formatoptions+=m
 
" 合并两行中文时，不在中间加空格：
set formatoptions+=B

set nopaste
set pastetoggle=<F9>
"NERDTree配置
map <F1> :NERDTreeToggle<CR>
map <C-F1> :NERDTreeFind<CR>
let NERDTreeChDirMode=2  "选中root即设置为当前目录
let NERDTreeQuitOnOpen=0 "打开文件时关闭树
let NERDTreeShowBookmarks=1 "显示书签
let NERDTreeMinimalUI=1 "不显示帮助面板
let NERDTreeDirArrows=0 "目录箭头 1 显示箭头  0传统+-|号
"snipMate
let g:snippets_dir = "~/.vim/bundle/snipMate/snippets"

autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate

