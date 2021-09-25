#-----------------------------
# default
#-----------------------------

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
bindkey '^]' forward-word

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# NOTE It may be over written by zsh-autosuggestions (but I'm not sure).
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#-----------------------------
# common
#-----------------------------

# prompt (pure)
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:prompt:success color green

# auto suggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# alias
if which batcat > /dev/null; then
  alias cat='batcat'
fi
alias code='setWinUser;/mnt/c/Users/$WINUSER/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
if which exa > /dev/null; then
  alias ll='exa -lha'
  alias tree='exa -T'
fi
if which nvim > /dev/null; then
  alias v='nvim'
else
  alias v='vim'
fi
if which docker > /dev/null; then
  alias dca='docker container attach'
  alias dce='docker container exec'
  alias dcl='docker container ls'
  alias dcr='docker container run -it --rm'
  alias dib='docker image build'
  alias dil='docker image ls'
  alias rstudio='\
    mkdir -p $HOME/.renv; \
    docker container run \
      -e DISABLE_AUTH=true -e RENV_PATHS_ROOT=/renv \
      -p 8787:8787 \
      -v $HOME/.renv:/renv -v $(pwd):/home/rstudio/project \
      rocker/rstudio:4.0.0'
  alias tmp='pwd'
fi
alias yyyymmdd='date "+%Y%m%d"'

#-----------------------------
# node
#-----------------------------

export PATH=$PATH:$HOME/n/bin

#-----------------------------
# python
#-----------------------------

# pyenv
eval "$(pyenv init -)"


#-----------------------------
# exa
#-----------------------------
export EXA_COLORS="da=1;35"


#-----------------------------
# wsl
#-----------------------------
export PATH=$PATH:/mnt/c/WINDOWS/system32
export PATH=$PATH:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0
function setWinUser() {
  # NOTE
  # It is not a good idea to run `powershell.exe` every time.
  # It will take a lot of time.
  export WINUSER=$(powershell.exe '$env:UserName' | tr -d "")
}

#-----------------------------
# nodejs
#-----------------------------
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
