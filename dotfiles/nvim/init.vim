"===== vim-plug =====
call plug#begin('~/.vim/plugged')
"common
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'itchyny/lightline.vim'
Plug 'kassio/neoterm'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'tomasr/molokai'
Plug 'yggdroot/indentLine'
"Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"python
Plug 'fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile'}
Plug 'Vimjas/vim-python-pep8-indent'
"js, ts
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/vim-jsx-improve'
"rust
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
"other
Plug 'aliva/vim-fish'
call plug#end()

"===== common =====
let mapleader = "\<space>"
syntax on
autocmd Filetype rust,javascriptreact,bq,sql syntax sync minlines=10000
filetype plugin indent on
set cursorline
let g:python3_host_prog = '$HOME/.pyenv/shims/python'

"===== NERDTree =====
nnoremap <leader>f :NERDTreeFocus<cr>
let NERDTreeCustomOpenArgs = {'file': {'reuse': 'all', 'where': 't'}, 'dir': {}}
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1

"===== bookmarks =====
let g:bookmark_auto_save = 0

"===== theme =====
colorscheme molokai
highlight Comment ctermfg=34

"===== prettier =====
function MyPrettier()
    let l:current_line = line(".")
    return "o\<esc>dd:%!npx prettier --stdin-filepath %" . l:current_line . "G"
endfunction
"PrettierAsync may be better but cannot be used with vim-bookmarks
nnoremap <expr><leader>p MyPrettier()

"===== indentLine =====
autocmd Filetype markdown,json,tex IndentLinesDisable
autocmd Filetype markdown,json,tex set conceallevel=0

"===== neoterm =====
let g:neoterm_default_mod = 'vertical'
let g:neoterm_autoscroll = 1
let g:neoterm_auto_repl_cmd = 0
tnoremap jj <c-\><c-n>
nnoremap <expr><leader>r g:myrepl_current_status == "none" ?
    \ MyRepl() : ":TREPLSendLine\<cr>\<down>0"
"nnoremap :: q:iT<space>
vnoremap <expr><leader>r g:myrepl_current_status == "none" ?
    \ MyRepl() : ":\<c-u>TREPLSendSelection\<cr>:T\<space>\<c-v>\<cr>\<cr>`>"
autocmd Filetype javascript vnoremap <buffer> <expr><leader>r g:myrepl_current_status == "none" ?
    \ MyRepl() : ":\<c-u>T\<space>.editor\<cr>:TREPLSendSelection\<cr>:T\<space>\<c-v>\<c-d>\<cr>`>"
nnoremap <expr><leader>t MyRepl()
let g:myrepl_current_status = "none"
function MyRepl()
    if g:myrepl_current_status == "none"
        if &filetype == "python"
            let g:myrepl_exit_command = ":T \<c-v>\<c-c>exit()\<cr>"
            let g:myrepl_current_status = &filetype
            return ":T ipython --no-autoindent\<cr>"
        elseif &filetype == "javascriptreact" || &filetype == "javascript"
            let g:myrepl_exit_command = ":T \<c-v>\<c-c>.exit\<cr>"
            let g:myrepl_current_status = &filetype
            return ":T node\<cr>"
        else
            let g:myrepl_exit_command = ":T \<c-v>\<c-a>\<c-v>\<c-k>exit\<cr>"
            let g:myrepl_current_status = "shell"
            return ":T echo 'using common repl!'\<cr>"
        endif
    else
        if g:myrepl_current_status == "shell"
            let g:myrepl_exit_command = ":T \<c-v>\<c-a>\<c-v>\<c-k>exit\<cr>"
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
nnoremap <leader>s :CocCommand snippets.openSnippetFiles<cr>
"mapping <cr> to <c-y> is recommended, but i don't like it
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> K :call <SID>show_documentation()<CR>
inoremap <silent><expr> <c-space> coc#refresh()
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

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
nnoremap <leader>n :tabnew<cr>
nnoremap <c-]> gt
nnoremap <c-[> gT

"===== quote & bracket =====
inoremap ( )<left>(
tnoremap ( )<left>(
inoremap { }<left>{
tnoremap { }<left>{
inoremap " "<left>"
tnoremap " "<left>"
inoremap ' '<left>'
tnoremap ' '<left>'
inoremap [ ]<left>[
tnoremap [ ]<left>[
inoremap ` `<left>`
tnoremap ` `<left>`
inoremap < ><left><
inoremap <<space> <<space>
inoremap <= <=
inoremap {<cr> {}<left><cr><esc><s-o>
inoremap (<cr> ()<left><cr><esc><s-o>
inoremap [<cr> []<left><cr><esc><s-o>
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
autocmd InsertLeave * set nopaste
vnoremap y y`>

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

"===== dictionary =====
"autocmd Filetype * execute 'setlocal dictionary+=~/.setting/dotfiles/nvim/dict/' . &filetype . '.txt'

"===== local_setting =====
runtime ./init_local.vim
