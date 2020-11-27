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
```

- `:PlugInstall`
- `pip install python-language-server`
- `:CocInstall coc-python`

now, completion is available in python file.
