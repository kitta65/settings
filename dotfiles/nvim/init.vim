"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state("$HOME/.dein")
  call dein#begin("$HOME/.dein")

  " read toml files
  " when you first use toml, dein#recache_runtimepath() may be needed
  call dein#load_toml("$HOME/.config/nvim/toml/dein.toml", {'lazy': 0})
  call dein#load_toml("$HOME/.config/nvim/toml/dein_lazy.toml", {'lazy': 1})

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
noremap! <c-h> <left>
noremap! <c-j> <down>
noremap! <c-k> <up>
noremap! <c-l> <right>
tnoremap <c-h> <left>
inoremap <c-j> <down>
tnoremap <c-k> <up>
tnoremap <c-l> <right>
nnoremap <s-g> <s-g>$
vnoremap <s-g> <s-g>$
nnoremap gg gg0
vnoremap gg gg0
vnoremap $ $h
function My0()
    let l:myzero_current_row = line(".")
    let l:myzero_next_col = strchars(matchstr(getline("."), "^\\s*"))+1
    let l:myzero_current_col = col(".")
    if 1 < l:myzero_next_col && l:myzero_next_col < l:myzero_current_col
        call cursor(l:myzero_current_row, l:myzero_next_col)
    else
        normal! 0
        " !... ignore mappint
    endif
endfunction
nnoremap 0 :call<space>My0()<cr>

"===== tab =====
nnoremap @t :tabnew<cr>:e<space>.<cr>
nnoremap <c-]> gt

"===== quote & bracket =====
noremap! ( ()<left>
noremap! { {}<left>
noremap! (; ();<left><left>
noremap! " ""<left>
noremap! ' ''<left>
noremap! [ []<left>
noremap! ` ``<left>
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
nnoremap / /\v
noremap! jj <esc>
noremap! ｊｊ <esc>
set number
set list
nnoremap @a :silent w !clip.exe<cr>
nnoremap @p :!echo<space>%:p<space>\|<space>sed<space>"s/\/mnt\/c\//C:/"<space>\|<space>clip.exe<cr><cr>
" i don't know why, but `silent` doesn't work in `@p`
function MyClip()
    " note: `execute 'normal! `<'` is unavailable here
    let l:dot_pos = getpos(".")
    let l:v_pos = getpos("v")
    if l:dot_pos[1] < l:v_pos[1] || (l:dot_pos[1] == l:v_pos[1] && l:dot_pos[2] <= l:v_pos[2])
        let l:start = "."
        let l:end = "v"
    else
        let l:start = "v"
        let l:end = "."
    endif
    let l:ltrim = strchars(getline(l:start)) - strchars(matchstr(getline(l:start), ".*", col(l:start)-1))
    let l:start_row = line(l:start)
    let l:rtrim = strchars(matchstr(getline(l:end), "^.*", col(l:end)-1))-1
    let l:end_row = line(l:end)
    return "y:\<c-u>silent" . l:start_row . "," . l:end_row . "!sed\<space>-E\<space>'1\<space>s/^.{" . l:ltrim . "}//'\<space>|\<space>sed\<space>-E\<space>'$\<space>s/.{" . l:rtrim . "}$//'\<space>|\<space>clip.exe\<cr>u"
endfunction
vnoremap <expr><c-c> MyClip()
vnoremap i <s-i>
vnoremap a <s-a>
vnoremap v <esc>
nnoremap <c-l> <c-w>w
nnoremap < 10<c-w><
nnoremap > 10<c-w>>
nnoremap <expr>@v (&paste == 0) ? ":set paste\<cr>" : ":set nopaste\<cr>"

"===== dictionary =====
autocmd Filetype * execute 'setlocal dictionary+=~/.setting/dotfiles/nvim/dict/' . &filetype . '.txt'
"set complete+=k

"===== local_setting =====
runtime ./init_local.vim
