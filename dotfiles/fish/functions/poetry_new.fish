function poetry_new
    poetry new $argv
    cd $argv
    rm -rf tests
    rm -rf $argv
    rm README.rst
    echo /.venv/ > .gitignore
    touch README.md
    poetry install
    git init
    cd ..
end
