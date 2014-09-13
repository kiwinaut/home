"--General
set nocompatible
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on
set t_Co=256
colorscheme gruvbox
let g:airline_theme='pencil'
set background=dark
set number
set laststatus=2
set hidden
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set smartindent
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set nobackup
set directory=~/.vim/swap
set tags+=~/.vim/tags/cpp
set comments=sl:/*,mb:\ *,elx:\ */
set shortmess+=i
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'   " insert tabs on the
"Plugin 'bbchung/clighter'   " insert tabs on the
call vundle#end()
let g:ycm_add_preview_to_completeopt = 0;
"let g:ycm_autoclose_preview_window_after_insertion= 1
set shortmess=a
set sessionoptions="buffers"
"--Maps
"let mapleader=","
nmap <silent> <leader>ev :e /home/soni/.vimrc<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <F1> <nop>
nnoremap <Q> <nop>
nnoremap _ :bd<CR>
"nnoremap ; <Plug>(easymotion-s)
"CtrlP
nmap <leader>cf :CtrlPCurFile<CR>
nmap <F3> :CtrlPCurWD<CR>
nmap <leader>f :CtrlP<CR>
nmap <F2> :CtrlPMRUFiles<CR>
nnoremap <space> :CtrlPBuffer<CR>
nmap <leader>cc :CtrlPClearAllCaches<CR>
set wildignore+=*/CMakeFiles/*,*/tmp/*,*.so,*.swp,*.zip,*.o,*.cmake,CMakeCache.txt

nnoremap <leader>pu :cd ..<CR>
nnoremap <leader>pt :cd %:p:h<CR>
"Save
nnoremap <c-s> :w<CR>
imap <c-s> <ESC>:w<CR>a
"<Fx>
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
map <F7> :make<CR>
map <S-F7> :make clean all<CR>
map <F8> :MBEToggle<CR>
nmap <F9> :TagbarToggle<CR>
nnoremap <F10> :NERDTreeToggle<CR>
"map <F12> <C-]>

nnoremap g<F11> :! g++ -Wall '%' -o '%:r'<CR>
nnoremap g<c-F11> :! g++ -Wall -std=c++11 '%' -o '%:r'<CR>
nnoremap g<F12> :! ./'%:r'<CR>
":imap <c-u> <esc>vawU<esc>i
nmap <leader>re :source ~/.vimrc<CR> :echo "DONE!"<CR>
vnoremap <leader>" <esc>a"<esc>`<i"<esc>`>l
":inoremap jj <esc>

":inoremap <esc> <nop>
nnoremap <S-tab> <c-w><c-w>
vnoremap <c-c> "+y

ino <c-j> <c-r>=TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>

"Show highlighting groups for current word
nmap <C-S-_> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
inoremap <CR> <ESC>:w<CR>
imap <C-CR> <s-CR><s-CR>end<Esc>-cc
"--vimwiki

let defaultw = {}
let defaultw.path = '~/vimwiki/'
let defaultw.index = 'main'

let integralw = {}
let integralw.path = '~/vimwiki/integral/'
let integralw.index = 'main'
let g:vimwiki_list = [defaultw, integralw]

"--gui
if has("gui_running")
  if has("gui_gtk2")
    set guifont=ubuntu\ mono\ 11
    set guioptions-=l
    set guioptions-=r
    set guioptions-=b
    set guioptions-=T
    set guioptions-=L
    set lines=64 columns=205
  endif
endif
z
"--folding
setlocal foldmethod=expr
"setlocal foldexpr=Getfold(v:lnum)
function! Getfold(lnum)
    "if getline(a:lnum) =~? '\v^\s*$'
     "   return '-1'
    "endif
    if getline(a:lnum + 1) =~? '\v^"--.*$'
        return '<1'
    endif
    return '1'
endfunction
"--personal functions

function! Make_dot_cpp()
	execute "e " . expand('%:r') . '.cpp'
endfunction
function! Make_dot_h()
	execute "e " . expand('%:r') . '.h'
endfunction
command! Makecpp call Make_dot_cpp()
command! Cdfile :cd execute expand("%:p:h")<CR>
set foldtext=MyFoldFunction()
set fillchars=fold:\
function! MyFoldFunction()
  let line = getline(v:foldstart)
  let lastline = getline(v:foldend)
  let numfolded = v:foldend - v:foldstart + 1
  return line . '  folded ' . numfolded . ' lines'
endfunction
highlight Folded term=bold ctermbg=0 ctermfg=7 guibg=bg guifg=fg
highlight FoldColumn term=bold ctermbg=10 ctermfg=7 guibg=bg guifg=fg
