#!/usr/bin/env fish
cd (dirname (status filename))

#===== pyenv =====
set -l ver "3.7.0"
pyenv install $ver
pyenv global $ver

#===== pipenv =====
pip install pipenv

#===== poetry =====
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
mkdir -p ~/.config/fish/completions
poetry completions fish > ~/.config/fish/completions/poetry.fish
poetry config virtualenvs.in-project true

#===== library =====
git clone https://github.com/dr666m1/library_python_mygeo.git $WKDIR/library/python/mygeo
git clone https://github.com/dr666m1/library_python_myds.git $WKDIR/library/python/myds
sudo apt install -y libxml2-dev zlib1g-dev build-essential python-dev # for python-igraph
