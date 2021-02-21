nnoremap <leader>a :silent w !pbcopy<cr>
"nnoremap <leader>d :!echo<space>%:p<space>\|<space>sed<space>"s/\/mnt\/c\//C:/"<space>\|<space>clip.exe<cr><cr>
"i don't know why, but `silent` doesn't work in `<leader>d`
vnoremap <leader>y y:call<space>system("pbcopy",@0)<cr>`>
nnoremap <leader>v v<esc>:set<space>paste<cr>a<cr><esc><bs>:r!pbpaste<cr>g<s-j>'<g<s-j>
