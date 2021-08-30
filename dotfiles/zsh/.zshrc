#-----------------------------
# default
#-----------------------------

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

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
alias cat='bat'
alias code='/mnt/c/Users/$WINUSER/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
alias ll='exa -lha'
alias tree='exa -T'
alias v='nvim'
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
export WINUSER=$(powershell.exe '$env:UserName' | tr -d '')
