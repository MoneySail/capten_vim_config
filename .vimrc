""" VIM整体的配置文件
"""
"" 基本配置

" gvim的配置
if has("gui_running")
" au GUIEnter * simalt ~x " 窗口启动时自动最大化
" colorscheme github
set t_Co=256
set guifont=Consolas:h14:cANSI
set guioptions-=m " 隐藏菜单栏
set guioptions-=T " 隐藏工具栏
set guioptions-=L " 隐藏左侧滚动条
set guioptions-=r " 隐藏右侧滚动条
set guioptions-=b " 隐藏底部滚动条
set showtabline=0 " 隐藏Tab栏
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-ruby/vim-ruby'
Plug 'terryma/vim-multiple-cursors'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ervandew/supertab'
Plug 'preservim/nerdcommenter'
Plug 'stormherz/tablify'
Plug 'python-mode/python-mode'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-exchange'
Plug 'haya14busa/incsearch.vim'
Plug 'preservim/nerdtree'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
call plug#end()

let g:airline#extensions#tabline#enabled=1
let g:airline_theme='onedark'
colorscheme Monokai

" TAB键设置
set ts=4
set expandtab
set autoindent
set shiftwidth=4

" backspace相关配置
set nocompatible
set backspace=indent,start
"  设置LEADER键及相关映射
let mapleader="\<Space>"
nmap <leader>w :w!<cr>  " 保存
nmap <leader>W :wa!<cr>  " 保存
nmap <leader>Q :qa!<cr>  " 保存
nmap le A
nmap lb 0
nmap <leader>q :q!<cr>    " 退出
map <leader>pp :setlocal paste!<cr>
map <silent> <leader><cr> :noh<cr>

" 插入模式基本映射
inoremap jj <ESC>:w<CR>
" inoremap ee <ESC>dd
inoremap , ,<SPACE>

"  设置显示行号和屏蔽开头
set nu
set shortmess=atI

"  中文语言相关
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set helplang=cn

" 设置缩进
set tabstop=4
set softtabstop=4

"禁止生成临时文件
set nobackup
set noswapfile

" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

" 总是显示状态行
set laststatus=2

" 侦测文件类型
filetype on
filetype plugin on
set showmatch

set smartindent
set autowrite

set incsearch "搜索加强
set hlsearch "搜索高亮

" 配置map键
" cmd map key
" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

set ruler

" 窗口映射
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap g\ vip:EasyAlign /\\/<CR>
vmap <C-c> "+y
map <leader><space><space> :FixWhitespace<cr>
"" 插件相关设置
" EasyMotion设置
map <Leader> <Plug>(easymotion-prefix)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" Emmet设置
let g:user_emmet_mode='a'
" let g:user_emmet_install_global = 0

 let g:user_emmet_settings = {
  \  'markdown' : {
  \    'extends' : 'html',
  \  },
  \}

" ag设置
let g:ag_prg="ag --vimgrep"
let g:ag_working_path_mode="r"
" Taglist设置
let Tlist_Use_Left_Window = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Show_One_File = 1
let Tlist_Sort_Type ='name'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth = 32
let Tlist_Ctags_Cmd ='ctags'
map <leader>t :TlistToggle<CR>
" insearch配置
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" supertab配置
let g:SuperTabRetainCompletionType=2

" easy-align配置
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"for fzf vim
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
let g:fzf_preview_window = ''
let g:fzf_preview_window = 'right:50%'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>g :GFiles<CR>
nnoremap <silent> <Leader>r :Rg<CR>
nnoremap <silent> <Leader>i :Lines<CR>
