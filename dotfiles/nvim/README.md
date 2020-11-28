# link
[vim-plug](https://github.com/junegunn/vim-plug)
[coc.nvim](https://github.com/neoclide/coc.nvim)

# requires
- nodejs

# vim-plug
## install

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

# coc.nvim
## install
```
# init.vim
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <TAB> coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : "\<tab>"
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
```

- `:PlugInstall`
- `pip install python-language-server pynvim`
- `:CocInstall coc-python`

now, completion is available in python file.

- `:CocInstall coc-snippets`
- `:CocInstall coc-dictionary`


if you see `pylint is not installed` every time, run `python.setLinter`

run `:CocConfig`, then

```
{
    "snippets": {
        "loadFromExtensions": false
    }
}
```

[syntaxl](https://github.com/SirVer/ultisnips/blob/8554371b57c8989cf73f73f288c456fb3f2a3a3a/doc/UltiSnips.txt#L548)

run `:CocCommand snippets.editSnippets`, then
```
snippet dt
`date +%Y-%m-%d`
endsnippet

snippet ch
##### ${1:chapter} #####$0
endsnippet
```
