"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state("$HOME/.nvim/dein")
  call dein#begin("$HOME/.nvim/dein")

  " read toml files
  " when you first use toml, dein#recache_runtimepath() may be needed
  call dein#load_toml("$HOME/.nvim/nvim/toml/dein.toml", {'lazy': 0})
  call dein#load_toml("$HOME/.nvim/nvim/toml/dein_lazy.toml", {'lazy': 1})

  " Required: 
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

"===== theme =====
highlight Comment ctermfg=22

"===== move =====
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
"tnoremap <c-h> <left>
inoremap <c-j> <down>
tnoremap <c-k> <up>
tnoremap <c-l> <right>
nnoremap <s-g> <s-g>$
vnoremap <s-g> <s-g>$
nnoremap gg gg0
vnoremap gg gg0

"===== tab =====
nnoremap @t :tabnew<cr>:e<space>.<cr>
nnoremap <c-]> gt

"===== quote & bracket =====
inoremap { {}<left>
inoremap ( ()<left>
inoremap (; ();<left><left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap [ []<left>
inoremap ` ``<left>
"inoremap < <><left>
tnoremap { {}<left>
tnoremap ( ()<left>
tnoremap " ""<left>
tnoremap ' ''<left>
tnoremap [ []<left>
tnoremap ` ``<left>
inoremap {<cr> {}<left><cr><esc><s-o>
inoremap (<cr> ()<left><cr><esc><s-o>
inoremap "<cr> ""<left><cr><esc><s-o>
inoremap '<cr> ''<left><cr><esc><s-o>
inoremap [<cr> []<left><cr><esc><s-o>
inoremap `<cr> ``<left><cr><esc><s-o>
"inoremap <<cr> <><left><cr><esc><s-o>
command -nargs=* MyQuote call MyQuote(<f-args>)
function MyQuote(l, ...)
    let l:r = get(a:000, 0, a:l)
    execute "normal! `>"
    execute "normal! a" . l:r
    execute "normal! `<"
    execute "normal! i" . a:l
endfunction
vnoremap "  :<c-u>call<space>MyQuote('"')<cr>
vnoremap '  :<c-u>call<space>MyQuote("'")<cr>
vnoremap {  :<c-u>call<space>MyQuote("{",     "}")<cr>
vnoremap (  :<c-u>call<space>MyQuote("(",     ")")<cr>
vnoremap [  :<c-u>call<space>MyQuote("[",     "]")<cr>
vnoremap `  :<c-u>call<space>MyQuote("`",     "`")<cr>
vnoremap <  :<c-u>call<space>MyQuote("<",     ">")<cr>
vnoremap /* :<c-u>call<space>MyQuote("/* ",   " */")<cr>
vnoremap <! :<c-u>call<space>MyQuote("<!-- ", " -->")<cr>
vnoremap q <esc>:MyQuote<space>

"===== conceal & show =====
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

"===== other =====
inoremap jj <esc>
inoremap ｊｊ <esc>
set number
set list
nnoremap @a :T clip_file %:p && exit<cr>
nnoremap @p :T clip_winpath %:p && exit<cr>
function MyClipFunc()
    if line(".") == line("v")
        let g:mysr = line(".")
        let g:myer = g:mysr
        if col(".") <= col("v")
            let g:mysc = strchars(getline(".")) - strchars(matchstr(getline("."), ".*", col(".")-1))
            let g:myec = strchars(matchstr(getline("."), ".*", col("v")-1)) - 1
        else
            let g:mysc = strchars(getline(".")) - strchars(matchstr(getline("."), ".*", col("v")-1))
            let g:myec = strchars(matchstr(getline("."), ".*", col(".")-1)) - 1
        endif
    elseif line(".") < line("v")
        let g:mysr = line(".")
        let g:myer = line("v")
        let g:mysc = strchars(getline(".")) - strchars(matchstr(getline("."), ".*", col(".")-1))
        let g:myec = strchars(matchstr(getline("v"), ".*", col("v")-1)) - 1
    else
        let g:mysr = line("v")
        let g:myer = line(".")
        let g:mysc = strchars(getline("v")) - strchars(matchstr(getline("v"), ".*", col("v")-1))
        let g:myec = strchars(matchstr(getline("."), ".*", col(".")-1)) - 1
    endif
    let g:mycmd = 'T clip_file ' . expand("%") . ' ' . g:mysr . ' ' . g:myer . ' ' . g:mysc . ' ' . g:myec . ' && exit'
    return "y:execute g:mycmd" . "\<cr>"
endfunction
vnoremap <expr>@y MyClipFunc()
vnoremap y y`>
vnoremap i <s-i>
vnoremap a <s-a>
vnoremap v <esc>
nnoremap <c-l> <c-w>w
nnoremap < 10<c-w><
nnoremap > 10<c-w>>
nnoremap <expr>@v (&paste == 0) ? ":set paste\<cr>" : ":set nopaste\<cr>"

"===== dictionary =====
autocmd Filetype * execute 'setlocal dictionary+=~/.nvim/nvim/dict/' . &filetype . '.txt'
"set complete+=k

"===== local_setting =====
runtime ./init_local.vim
