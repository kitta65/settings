"===== vim-plug =====
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'kassio/neoterm'
Plug 'tomasr/molokai'
Plug 'yggdroot/indentLine'
Plug 'lervag/vimtex'
Plug 'aliva/vim-fish'
Plug 'neoclide/vim-jsx-improve'
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
"Plug 'luochen1990/rainbow'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'rust-lang/rust.vim'
Plug 'MattesGroeger/vim-bookmarks'
call plug#end()

"===== common =====
let mapleader = "\<space>"
syntax enable
filetype plugin indent on

"===== NERDTree =====
nnoremap <leader>f :NERDTreeFocus<cr>
let NERDTreeCustomOpenArgs = {'file': {'reuse': 'all', 'where': 't'}, 'dir': {}}
let NERDTreeQuitOnOpen = 1

"===== bookmarks =====
let g:bookmark_auto_save = 0

"===== theme =====
colorscheme molokai
highlight Comment ctermfg=22

"===== prettier =====
autocmd Filetype rust nnoremap <buffer> <leader>p :RustFmt<cr>
"===== vim-rainbow =====
"let g:rainbow_active = 1
"let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

"===== indentLine =====
autocmd Filetype markdown,json,tex IndentLinesDisable

"===== neoterm =====
let g:neoterm_default_mod = 'vertical'
let g:neoterm_autoscroll = 1
let g:neoterm_auto_repl_cmd = 0
tnoremap jj <c-\><c-n>
nnoremap <expr><leader>r g:myrepl_current_status == "none" ?
    \ MyRepl() : ":TREPLSendLine\<cr>\<down>0"
nnoremap :: q:iT<space>
vnoremap <expr><leader>r g:myrepl_current_status == "none" ?
    \ MyRepl() : ":\<c-u>TREPLSendSelection\<cr>:T\<space>\<c-v>\<cr>\<cr>`>"
autocmd Filetype javascript vnoremap <buffer> <expr><leader>r g:myrepl_current_status == "none" ?
    \ MyRepl() : ":\<c-u>T\<space>.editor\<cr>:TREPLSendSelection\<cr>:T\<space>\<c-v>\<c-d>\<cr>`>"
nnoremap <expr><leader>t MyRepl()
let g:myrepl_current_status = "none"
function MyRepl()
    if g:myrepl_current_status == "none"
        if &filetype == "python"
            let g:myrepl_exit_command = ":T exit()\<cr>"
            let g:myrepl_current_status = &filetype
            return ":T ipython --no-autoindent\<cr>"
        elseif &filetype == "javascriptreact" || &filetype == "javascript"
            let g:myrepl_exit_command = ":T .exit\<cr>"
            let g:myrepl_current_status = &filetype
            return ":T node\<cr>"
        else
            let g:myrepl_exit_command = ":T exit\<cr>"
            let g:myrepl_current_status = "shell"
            return ":T echo 'using common repl!'\<cr>"
        endif
    else
        if g:myrepl_current_status == "shell"
            let g:myrepl_exit_command = ":T exit\<cr>"
            let g:myrepl_current_status = "none"
            return g:myrepl_exit_command
        else
            let g:myrepl_current_status = "shell"
            return g:myrepl_exit_command
        endif
    endif
endfunction
nnoremap <expr><leader>w g:myrepl_current_status == "none" ? MyRepl() : ":Ttoggle\<cr>"

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
inoremap <c-e> <esc>ea
tnoremap <c-e> <esc>ea
inoremap <c-b> <esc>bi
tnoremap <c-b> <esc>bi
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
"nnoremap <leader>t :tabnew<cr>:e<space>.<cr>
nnoremap <c-]> gt
nnoremap <c-[> gT

"===== quote & bracket =====
inoremap ( ()<left>
tnoremap ( ()<left>
inoremap { {}<left>
tnoremap { {}<left>
inoremap " ""<left>
tnoremap " ""<left>
inoremap ' ''<left>
tnoremap ' ''<left>
inoremap [ []<left>
tnoremap [ []<left>
inoremap ` ``<left>
tnoremap ` ``<left>
inoremap < <><left>
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

"===== yank & paste =====
nnoremap <leader>a :silent w !clip.exe<cr>
nnoremap <leader>d :!echo<space>%:p<space>\|<space>sed<space>"s/\/mnt\/c\//C:/"<space>\|<space>clip.exe<cr><cr>
"i don't know why, but `silent` doesn't work in `<leader>d`
vnoremap <leader>y y:call<space>system("clip.exe",@0)<cr>`>
vnoremap y y`>
"nnoremap <expr><leader>v (&paste == 0) ? ":set paste\<cr>" : ":set nopaste\<cr>"
autocmd InsertLeave * set nopaste
nnoremap <leader>v v<esc>:set<space>paste<cr>a<cr><esc><bs>:r!powershell.exe<space>Get-Clipboard<cr>g<s-j>'<g<s-j>


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
nnoremap <leader>p :PrettierAsync<cr>

"===== dictionary =====
autocmd Filetype * execute 'setlocal dictionary+=~/.setting/dotfiles/nvim/dict/' . &filetype . '.txt'

"===== local_setting =====
runtime ./init_local.vim
