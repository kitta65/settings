"===== vim-plug =====
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'kassio/neoterm'
Plug 'tomasr/molokai'
Plug 'yggdroot/indentLine'
Plug 'lervag/vimtex'
Plug 'aliva/vim-fish'
Plug 'neoclide/vim-jsx-improve'
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()

"===== common =====
let mapleader = "\<space>"

"===== theme =====
colorscheme molokai
highlight Comment ctermfg=22

"===== indentLine =====
autocmd Filetype markdown,json,tex IndentLinesDisable

"===== neoterm =====
let g:neoterm_default_mod = 'vertical'
let g:neoterm_autoscroll = 1
let g:neoterm_auto_repl_cmd = 0
tnoremap jj <c-\><c-n>
nnoremap <leader>e :T exit<cr>
nnoremap <leader>r :TREPLSendLine<cr><down>0
nnoremap :: q:iT<space>
vnoremap <leader>r :<c-u>TREPLSendSelection<cr>:T<space><c-v><cr><cr>`>
autocmd Filetype javascript vnoremap <leader>r :<c-u>T<space>.editor<cr>:TREPLSendSelection<cr>:T<space><c-v><c-d><cr>
let s:venv_path = finddir("venv", ".;")
if s:venv_path != ""
    let g:neoterm_repl_python = 'source ' . s:venv_path . '/bin/activate.fish; and ipython --no-autoindent'
endif

"===== coc.nvim =====
inoremap <silent><expr> <tab> coc#expandableOrJumpable() ? "\<c-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" : "\<tab>"
vmap <tab> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
nnoremap <leader>s :tabedit<space>%<cr>:CocCommand snippets.openSnippetFiles<cr>
"mapping <cr> to <c-y> is recommended, but i don't like it
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"===== move cursor =====
noremap! <c-h> <left>
tnoremap <c-h> <left>
noremap! <c-j> <down>
tnoremap <c-j> <down>
noremap! <c-k> <up>
tnoremap <c-k> <up>
noremap! <c-l> <right>
tnoremap <c-l> <right>
nnoremap <s-g> <s-g>$
vnoremap <s-g> <s-g>$
nnoremap gg gg0
vnoremap gg gg0
vnoremap $ $h
function My0()
    let l:myzero_next_col = strchars(matchstr(getline("."), "^\\s*"))+1
    let l:myzero_current_col = col(".")
    if 1 < l:myzero_next_col && l:myzero_next_col < l:myzero_current_col
        return "0w"
    else
        return "0"
        "!... ignore mapping
    endif
endfunction
nnoremap <expr>0 My0()
vnoremap <expr>0 My0()

"===== tab =====
nnoremap <leader>t :tabnew<cr>:e<space>.<cr>
nnoremap <c-]> gt
nnoremap <c-[> gT

"===== quote & bracket =====
noremap! ( ()<left>
tnoremap ( ()<left>
noremap! { {}<left>
tnoremap { {}<left>
noremap! " ""<left>
tnoremap " ""<left>
noremap! ' ''<left>
tnoremap ' ''<left>
noremap! [ []<left>
tnoremap [ []<left>
noremap! ` ``<left>
tnoremap ` ``<left>
noremap! < <><left>
inoremap {<cr> {}<left><cr><esc><s-o>
inoremap (<cr> ()<left><cr><esc><s-o>
inoremap "<cr> ""<left><cr><esc><s-o>
inoremap '<cr> ''<left><cr><esc><s-o>
inoremap [<cr> []<left><cr><esc><s-o>
inoremap `<cr> ``<left><cr><esc><s-o>
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

"===== clipboard =====
nnoremap <leader>a :silent w !clip.exe<cr>
nnoremap <leader>d :!echo<space>%:p<space>\|<space>sed<space>"s/\/mnt\/c\//C:/"<space>\|<space>clip.exe<cr><cr>
"i don't know why, but `silent` doesn't work in `<leader>d`
vnoremap <leader>y y:call<space>system("clip.exe",@0)<cr>

"===== other =====
nnoremap / /\v
noremap! jj <esc>
noremap! ｊｊ <esc>
set number
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
vnoremap i <s-i>
vnoremap a <s-a>
vnoremap v <esc>
"nnoremap <c-l> <c-w>l
nnoremap <c-l> <c-w>w
nnoremap <c-h> <c-w>h
nnoremap <leader>w 10<c-w><
nnoremap <expr><leader>v (&paste == 0) ? ":set paste\<cr>" : ":set nopaste\<cr>"
autocmd InsertLeave * set nopaste
nnoremap <leader>p :PrettierAsync<cr>

"===== dictionary =====
autocmd Filetype * execute 'setlocal dictionary+=~/.setting/dotfiles/nvim/dict/' . &filetype . '.txt'

"===== local_setting =====
runtime ./init_local.vim
