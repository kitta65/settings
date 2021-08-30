#------------------------------
# python
#------------------------------

# NOTE The document says these three commands should be added also into `~/.profile` but it seems unnecessary.
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
