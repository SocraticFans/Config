set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'AutoComplPop'

let &termencoding=&encoding
set fileencodings=utf-8,ucs-bom,cp936
"auto indent
set autoindent
"set ai
"set smartindent
set cindent
" show line number
set number
" expande tab
" set expandtab
set tabstop=4
set shiftwidth=4
" no folding code
set nofoldenable
" highlight search
set hlsearch
" enbale syntax highlight
syntax on
" align function arguments
set cino+=(0

set cscopequickfix=s-,c-,d-,i-,t-,e-

syntax enable
"colorscheme molokai

" filter the unwanted files
let NERDTreeIgnore=['\.o$', '\.lo$', '\.la$', 'tags', 'cscope.*', '\.d']

" auto launch NERDTree
function! AutoNERDTree()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call AutoNERDTree()

" auto update tags
function! UpdateTags()
    " only update the tags when we've created one
    if !filereadable("tags")
        return
    endif

    " use the path relative to pwd
    let _file = expand("%")
    let _cmd = 'ctags --append "' . _file . '"'
    let _ret = system(_cmd)
    unlet _cmd
    unlet _file
    unlet _ret
endfunction

autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()

" easy copy to/paste from system clipboard
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gp

" show function names in c
function! ShowFuncName()
    let lnum = line(".")
    let col = col(".")
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
    echohl None
    call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfunction
map ,f :call ShowFuncName() <CR>

" highlight unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" shotcuts for fuzzyfinder
map ff <esc>:FufFile **/<cr>
map ft <esc>:FufTag<cr>
"map <silent> <c-\> :FufTag! <c-r>=expand('<cword>')<cr><cr>

" shotcut for taglist
noremap <F4> :TlistToggle<CR>

" hight lines longer than 80 characters
"if exists('+colorcolumn')
"  set colorcolumn=80
" else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" endif

" show current function name
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map F :call ShowFuncName() <CR>

" make hjkl movements accessible from insert mode via the <Alt> modifier key
inoremap <S-A-h> <C-o>h
inoremap <S-A-j> <C-o>j
inoremap <S-A-k> <C-o>k
inoremap <S-A-l> <C-o>l
" quick input closing bracket
inoremap {<CR> {<CR>}<ESC>O

filetype plugin on
filetype indent on
" gofmt .go source files when they are saved
autocmd FileType go autocmd BufWritePre <buffer> Fmt
"au BufRead,BufNewFile *.proto set filetype=proto
"au syntax proto source ~/.vim/syntax/proto.vim
au BufRead,BufNewFile *.proto setfiletype proto

"map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

hi PmenuSel ctermbg=green ctermfg=white
set backspace=2

" 注释绿色
highlight Comment ctermfg=green guifg=green

map <F2> :call TitleDet()<cr>'s
function AddTitle()
    call append(0,"/*===========================================================")
    call append(1,"# Filename: ".expand("%:t"))
    call append(2,"# Author: SGod	socratifans@163.com")
    call append(3,"# Created on: ".strftime("%Y-%m-%d %H:%M"))
    call append(4,"# Last modified: ".strftime("%Y-%m-%d %H:%M"))
    call append(5,"#")
    call append(6,"# Description: ")
    call append(7,"=============================================================*/")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction
"更新最近修改时间和文件名
function UpdateTitle()
    normal m'
    execute '/# *Last modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/# *Filename:/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
"判断前10行代码里面，是否有Last modified这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
    let n=1
    "默认为添加
    while n < 10
        let line = getline(n)
        if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction
